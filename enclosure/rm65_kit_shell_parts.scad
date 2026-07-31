/*
  Shared shell primitives, mounts, feet and interface cutouts for RM65 KIT.
  Included by rm65_kit_enclosure.scad; depends on parent globals.
*/

// ========== 分区：公开 API ==========
module rounded_box(size, r) {
    hull()
        for (x = [r, size[0] - r], y = [r, size[1] - r])
            translate([x, y, 0]) cylinder(r = r, h = size[2]);
}

module local_rib_cross(h) {
    // Used only for free-standing PCB supports where no nearby wall exists.
    for (a = [0, 90])
        rotate([0, 0, a])
            translate([-boss_rib_length / 2, -boss_rib_thickness / 2, 0])
                cube([boss_rib_length, boss_rib_thickness, h]);
}

module reinforced_post(h, hole_d) {
    difference() {
        union() {
            cylinder(d1 = case_post_reinforce_diameter,
                     d2 = case_post_outer_diameter,
                     h = min(case_post_reinforce_height, h));
            if (h > case_post_reinforce_height)
                translate([0, 0, case_post_reinforce_height])
                    cylinder(d = case_post_outer_diameter,
                             h = h - case_post_reinforce_height);
        }
        translate([0, 0, -0.1])
            cylinder(d = hole_d, h = h + 0.2);
    }
}

module ribs_to_nearest_walls(x, y, h, z_start = 0) {
    // Each corner boss is tied only to its two nearest inner walls.
    // The ribs remain inside the enclosure and make a direct wall/boss load path.
    rib_h = min(case_post_reinforce_height, h);
    x_left = x < outer_x / 2;
    y_front = y < outer_y / 2;
    // 0.20 mm overlap prevents merely coplanar contact after STL tessellation.
    x_len = x_left ? x - wall + 0.20 : outer_x - wall - x + 0.20;
    y_len = y_front ? y - wall + 0.20 : outer_y - wall - y + 0.20;

    translate([x_left ? -x_len : 0, -boss_rib_thickness / 2, z_start])
        cube([x_len, boss_rib_thickness, rib_h]);
    translate([-boss_rib_thickness / 2, y_front ? -y_len : 0, z_start])
        cube([boss_rib_thickness, y_len, rib_h]);
}

module case_post_locations(h, hole_d) {
    for (x = [case_post_inset, outer_x - case_post_inset],
         y = [case_post_inset, outer_y - case_post_inset]) {
        translate([x, y, 0]) reinforced_post(h, hole_d);
        translate([x, y, 0]) ribs_to_nearest_walls(x, y, h);
    }
}

module top_reinforced_post(h, hole_d) {
    reinforce_h = min(case_post_reinforce_height, h);
    difference() {
        union() {
            if (h > reinforce_h)
                cylinder(d = case_post_outer_diameter,
                         h = h - reinforce_h);
            // Flare is at the roof end, not at the split-plane end.
            translate([0, 0, h - reinforce_h])
                cylinder(d1 = case_post_outer_diameter,
                         d2 = case_post_reinforce_diameter,
                         h = reinforce_h);
        }
        translate([0, 0, -0.1])
            cylinder(d = hole_d, h = h + 0.2);
    }
}

module top_case_post_locations(z0, h) {
    for (x = [case_post_inset, outer_x - case_post_inset],
         y = [case_post_inset, outer_y - case_post_inset]) {
        translate([x, y, z0])
            top_reinforced_post(h, case_screw_pilot);
        // Ribs occupy only the roof-side reinforced zone and meet both
        // nearest top-shell inner walls. Nothing protrudes below z0.
        translate([x, y, z0])
            ribs_to_nearest_walls(x, y, h,
                                  h - min(case_post_reinforce_height, h));
    }
}

module pcb_standoffs() {
    if (pcb_holes_enabled)
        for (p = pcb_holes)
            translate([
                pcb_origin_x + p[0],
                pcb_origin_y + p[1],
                floor_thickness - 0.20
            ])
                difference() {
                    union() {
                        cylinder(d1 = pcb_standoff_outer_diameter + 2.0,
                                 d2 = pcb_standoff_outer_diameter,
                                 h = min(2.2, pcb_standoff_height + 0.2));
                        if (pcb_standoff_height > 2.0)
                            translate([0, 0, 2.2])
                                cylinder(d = pcb_standoff_outer_diameter,
                                         h = pcb_standoff_height - 2.0);
                        local_rib_cross(min(2.2, pcb_standoff_height + 0.2));
                        translate([0, 0, pcb_standoff_height + 0.2])
                            cylinder(d1 = pcb_guide_diameter,
                                     d2 = pcb_guide_diameter,
                                     h = pcb_guide_height);
                    }
                    translate([0, 0, -0.1])
                        cylinder(d = pcb_pilot_diameter,
                                 h = pcb_standoff_height + 0.2
                                     + pcb_guide_height + 0.2);
                }
}

module foot_recesses() {
    for (x = [bottom_foot_inset, outer_x - bottom_foot_inset],
         y = [bottom_foot_inset, outer_y - bottom_foot_inset])
        translate([x, y, -0.1]) {
            cylinder(d1 = foot_recess_mouth_diameter,
                     d2 = foot_recess_diameter,
                     h = min(0.45, foot_recess_depth));
            translate([0, 0, min(0.45, foot_recess_depth) - 0.01])
                cylinder(d = foot_recess_diameter,
                         h = foot_recess_depth
                             - min(0.45, foot_recess_depth) + 0.12);
        }
}

module foot_pad() {
    exposed_h = foot_pad_total_height - foot_pad_insert_height;
    union() {
        cylinder(d = foot_pad_diameter, h = exposed_h);
        translate([0, 0, exposed_h])
            cylinder(d = foot_pad_diameter,
                     h = max(0.1, foot_pad_insert_height - 0.45));
        translate([0, 0, foot_pad_total_height - 0.45])
            cylinder(d1 = foot_pad_diameter,
                     d2 = foot_pad_tip_diameter, h = 0.45);
    }
}

module interface_cutouts() {
    if (interface_cutouts_enabled) {
        // Right wall: all six metal RJ45 faces are essentially contiguous on
        // the delivered board. One continuous opening avoids fragile FDM ribs.
        translate([outer_x + 1 - interface_cut_depth,
                   pcb_origin_y + rj45_opening_y0,
                   rj45_z_center - rj45_opening_height / 2])
            cube([interface_cut_depth,
                  rj45_opening_y1 - rj45_opening_y0,
                  rj45_opening_height]);

        // Bottom/front wall: GPIO_RST, SYS_RST, USB-A and DC.
        for (x = switch_x)
            translate([pcb_origin_x + x, interface_cut_depth - 1,
                       switch_z_center])
                rotate([90, 0, 0])
                    cylinder(d = switch_tool_diameter,
                             h = interface_cut_depth);
        // Exterior guide funnels keep both reset buttons finger-inaccessible.
        for (x = switch_x)
            translate([pcb_origin_x + x, switch_recess_depth,
                       switch_z_center])
                rotate([90, 0, 0])
                    cylinder(d1 = switch_tool_diameter,
                             d2 = switch_recess_diameter,
                             h = switch_recess_depth + 0.1);
        translate([pcb_origin_x + usb_x - usb_opening_width / 2,
                   -1,
                   usb_z_center - usb_opening_height / 2])
            cube([usb_opening_width, interface_cut_depth,
                  usb_opening_height]);
        translate([pcb_origin_x + dc_x, interface_cut_depth - 1,
                   dc_z_center])
            rotate([90, 0, 0])
                cylinder(d = dc_shell_opening_diameter,
                         h = interface_cut_depth);

        // Left wall: USB-TTL Type-C only. Maintenance pin headers stay closed.
        // Depth spans the left service bay so the mouth still reaches the PCB.
        translate([-1,
                   pcb_origin_y + typec_y - typec_opening_width / 2,
                   typec_z_center - typec_opening_height / 2])
            cube([typec_tunnel_depth + 1, typec_opening_width,
                  typec_opening_height]);

        // Top face near the rear edge: nine vertical LED/light-pipe windows.
        for (x = led_x)
            translate([pcb_origin_x + x, pcb_origin_y + led_y,
                       led_guide_lower_z - 0.1])
                cylinder(d = led_shell_hole_diameter,
                         h = outer_z - led_guide_lower_z + 0.2);
    }
}

module led_lightpipe_guides() {
    // The delivered-board photo shows the coloured LED domes from above.
    // Nine roof-side sleeves align vertically with the official XY row, stop
    // clear of the board, and isolate optional 3 mm light pipes from bleed.
    if (interface_cutouts_enabled)
        for (x = led_x) {
            guide_len = outer_z - top_thickness - led_guide_lower_z + 0.20;
            translate([pcb_origin_x + x, pcb_origin_y + led_y,
                       led_guide_lower_z])
                difference() {
                    cylinder(d = led_guide_outer_diameter, h = guide_len);
                    translate([0, 0, -0.1])
                        cylinder(d = led_shell_hole_diameter,
                                 h = guide_len + 0.2);
                }
        }
}

