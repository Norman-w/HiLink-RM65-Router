/*
  HiLink RM65 KIT enclosure — adjustable first prototype

  IMPORTANT: the KIT has not yet been measured. Every parameter in this
  section must be checked against the delivered board before printing.
  The 152 x 109 mm PCB outline is copied from the repository's nominal
  dimension drawing; it is not a physical inspection result.
*/

// Export target: "bottom", "top", "top_assembly", "io_panel",
// "foot_pad", or "assembly".
part = "assembly";

// ---------- MEASURE THESE ON THE DELIVERED KIT ----------
pcb_x = 152.0;                 // nominal only
pcb_y = 109.0;                 // nominal only
pcb_thickness = 1.6;
pcb_side_clearance = 8.0;      // room for independent shell and PCB M2 bosses
clearance_below_pcb = 4.0;     // tallest solder joint below the PCB
clearance_above_pcb = 27.0;    // tallest heatsink/component above PCB

// PCB mounting holes, measured from the PCB lower-left corner.
// Defaults are conservative corner estimates, NOT verified hole locations.
pcb_holes_enabled = true;
pcb_holes = [
    [4.0, 4.0],
    [4.0, pcb_y - 4.0],
    [pcb_x - 4.0, 4.0],
    [pcb_x - 4.0, pcb_y - 4.0]
];
pcb_screw_nominal = 2.0;       // user-selected M2 PCB fixing
pcb_hole_diameter = 2.3;       // M2 printed clearance; tune after test print
pcb_standoff_outer_diameter = 6.0;
pcb_standoff_height = clearance_below_pcb;
pcb_guide_diameter = 3.0;      // short lead-in above the standoff
pcb_guide_height = 1.0;

// The replaceable I/O panel occupies the front wall. Measure connector
// centres/heights before replacing the conservative single service opening.
io_panel_enabled = true;
io_panel_width = 126.0;
io_panel_height = 12.0;        // fits bottom wall; connector cutouts unverified
io_panel_thickness = 2.0;
io_openings = [                // [centre_x, centre_z, width, height]
    [io_panel_width / 2, io_panel_height / 2, 112.0, 8.0]
];

// Dedicated DC and Reset cuts belong only to the replaceable I/O panel.
// Both stay OFF until their centres and component protrusion are measured.
dc_opening_enabled = false;
dc_panel_x = 0;                // measure from panel left edge
dc_panel_z = 0;                // measure from panel bottom edge
dc_opening_diameter = 12.0;    // verify against J1 barrel/nut, not footprint name
dc_plug_grip_diameter = 18.0;  // external hand/finger access envelope
dc_cable_bend_clearance = 35.0;// free space outside panel; documentation only

reset_opening_enabled = false;
reset_panel_x = 0;             // measure actual Reset switch centre
reset_panel_z = 0;
reset_tool_hole_diameter = 2.2;// paperclip/pin access, prevents finger presses
reset_recess_diameter = 6.0;   // shallow outer funnel for tool guidance
reset_recess_depth = 1.2;      // must remain below io_panel_thickness

// ---------- PCB-DOC XY INTERFACE CUTOUT CANDIDATE ----------
// These are real Boolean openings in the shell. XY is audited from PcbDoc;
// all Z centres, heights and clearances remain measurement parameters.
interface_cutouts_enabled = true;
interface_z_center = 13.0;

rj45_y = [15.64, 30.89, 46.14, 61.39, 75.86, 91.74];
rj45_opening_width = 15.2;     // along PCB Y, candidate clearance
rj45_opening_height = 16.0;

switch_x = [11.29, 22.03];     // SW1/SW2; Reset/WPS mapping unverified
switch_y = 1.94;               // component reference; front-wall hole uses X
switch_tool_diameter = 3.2;
usb_x = 38.40;
usb_y = -2.48;                 // component reference; front-wall hole uses X
usb_opening_width = 16.0;
usb_opening_height = 10.0;
dc_x = 99.95;
dc_y = 6.25;                   // component reference; front-wall hole uses X
dc_shell_opening_diameter = 12.0;

led_x = [15.01, 21.18, 27.34, 33.51, 39.67,
         45.84, 52.07, 58.23, 64.40];
led_y = 102.06;                // component reference; rear-wall hole uses X
led_shell_hole_diameter = 3.6;

maintenance_y = [36.67, 52.38, 67.62, 84.13, 95.56];
maintenance_x = [1.47, 1.42, 1.42, 1.42, 1.42];
maintenance_pins = [3, 6, 6, 8, 2];
maintenance_opening_height = 10.0;
maintenance_pitch = 2.54;
maintenance_side_clearance = 2.0;

// Optional external antenna bulkhead holes on the rear wall.
// Confirm antenna type, connector diameter, spacing and RF port mapping first.
antenna_holes_enabled = true;
antenna_hole_diameter = 6.5;
antenna_layout = "rear_spread";      // package-B: rear 3 + corner 2 outward
antenna_z = 24.0;                    // measured from enclosure bottom
antenna_pivot_keepout_radius = 12.0; // mechanical sweep only; not RF spacing
antenna_x = [22, 49, 76, 103, 130]; // legacy rear-row option
antenna_feed_anchor_width = 8.0;
antenna_feed_anchor_depth = 3.0;
antenna_feed_anchor_height = 6.0;
antenna_feed_anchor_slot = 3.0;

// PCB data confirms a row of nine 3 mm LEDs, but their lead bend/orientation
// and required light-pipe surface are not physically verified. No hole is cut.
led_windows_enabled = false;
led_nominal_x = [15.01, 21.18, 27.35, 33.51, 39.68, 45.84, 52.01, 58.17, 64.34];
led_nominal_y = 102.06;        // PCB lower-left datum, derived from PcbDoc

// ---------- PRINT / FIT PARAMETERS ----------
wall = 2.4;
floor_thickness = 2.4;
top_thickness = 2.4;
pcb_origin_x = wall + pcb_side_clearance;
pcb_origin_y = wall + pcb_side_clearance;
corner_radius = 4.0;
lid_overlap = 5.0;
fit_clearance = 0.30;         // per side; tune for the printer/material
lid_skirt_thickness = 1.2;    // inner skirt; avoids overlapping outer walls
panel_fit_clearance = 0.35;

foot_recess_diameter = 11.0;
foot_recess_depth = 1.0;       // leaves 1.4 mm of the 2.4 mm floor
foot_recess_mouth_diameter = 11.4;
foot_pad_diameter = 11.2;      // 0.2 mm TPU interference vs recess
foot_pad_total_height = 3.2;
foot_pad_insert_height = 1.0;
foot_pad_tip_diameter = 10.8;  // lead-in chamfer, no internal undercut
bottom_foot_inset = 30.0;      // clears shell screws and PCB bosses

case_screw_nominal = 2.0;      // M2 countersunk enclosure screws
case_screw_clearance = 2.3;    // reference-project fit
case_screw_pilot = 1.7;
case_screw_head_diameter = 5.0;
case_screw_head_depth = 1.8;
case_post_outer_diameter = 5.0;
case_post_reinforce_diameter = 7.5;
case_post_reinforce_height = 2.5;
boss_rib_thickness = 1.6;
boss_rib_length = 5.0;
case_post_inset = 8.0;

vent_enabled = true;
vent_slot_width = 3.0;
vent_slot_length = 38.0;
vent_rows = 4;
vent_columns = 3;
vent_pitch_x = 45.0;
vent_pitch_y = 9.0;

brand_enabled = true;
brand_font = "Liberation Sans:style=Bold";
brand_bridge = 1.0;            // stencil bridge retains O/R/A/o counters
brand_line1 = "NORMAN";
brand_line2 = "Router v1";
brand_line1_size = 8.0;
brand_line2_size = 4.8;
brand_line1_y = 94.0;          // above vent array, away from rear edge
brand_line2_y = 85.0;

// Preview-only separation. Ignored by individual STL exports.
assembly_gap = 3.0;
$fn = 48;

inner_x = pcb_x + 2 * pcb_side_clearance;
inner_y = pcb_y + 2 * pcb_side_clearance;
outer_x = inner_x + 2 * wall;
outer_y = inner_y + 2 * wall;
antenna_rear_x = [12, 45, outer_x / 2, outer_x - 45, outer_x - 12];
split_z = floor_thickness + clearance_below_pcb + pcb_thickness + 8.0;
outer_z = floor_thickness + clearance_below_pcb + pcb_thickness
          + clearance_above_pcb + top_thickness;

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
    x_len = x_left ? x - wall : outer_x - wall - x;
    y_len = y_front ? y - wall : outer_y - wall - y;

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
                wall + pcb_side_clearance + p[0],
                wall + pcb_side_clearance + p[1],
                floor_thickness
            ])
                difference() {
                    union() {
                        cylinder(d1 = pcb_standoff_outer_diameter + 2.0,
                                 d2 = pcb_standoff_outer_diameter,
                                 h = min(2.0, pcb_standoff_height));
                        if (pcb_standoff_height > 2.0)
                            translate([0, 0, 2.0])
                                cylinder(d = pcb_standoff_outer_diameter,
                                         h = pcb_standoff_height - 2.0);
                        local_rib_cross(min(2.0, pcb_standoff_height));
                        translate([0, 0, pcb_standoff_height])
                            cylinder(d1 = pcb_guide_diameter,
                                     d2 = pcb_hole_diameter,
                                     h = pcb_guide_height);
                    }
                    translate([0, 0, -0.1])
                        cylinder(d = pcb_hole_diameter,
                                 h = pcb_standoff_height
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
        // Right wall: RJ3 four-port block + RJ2/RJ1 singles, six openings.
        for (y = rj45_y)
            translate([outer_x - wall - 1,
                       pcb_origin_y + y - rj45_opening_width / 2,
                       interface_z_center - rj45_opening_height / 2])
                cube([wall + 2, rj45_opening_width,
                      rj45_opening_height]);

        // Bottom/front wall: two recessed button tool holes, USB-A and DC.
        for (x = switch_x)
            translate([pcb_origin_x + x, wall + 1,
                       interface_z_center])
                rotate([90, 0, 0])
                    cylinder(d = switch_tool_diameter, h = wall + 2);
        translate([pcb_origin_x + usb_x - usb_opening_width / 2,
                   -1,
                   interface_z_center - usb_opening_height / 2])
            cube([usb_opening_width, wall + 2, usb_opening_height]);
        translate([pcb_origin_x + dc_x, wall + 1, interface_z_center])
            rotate([90, 0, 0])
                cylinder(d = dc_shell_opening_diameter, h = wall + 2);

        // Top/rear wall: nine LED/light-pipe access holes.
        for (x = led_x)
            translate([pcb_origin_x + x, outer_y + 1,
                       interface_z_center])
                rotate([90, 0, 0])
                    cylinder(d = led_shell_hole_diameter, h = wall + 2);

        // Left wall: individual access windows for maintenance headers.
        for (i = [0 : len(maintenance_y) - 1])
            translate([-1,
                       pcb_origin_y + maintenance_y[i]
                       - (maintenance_pins[i] * maintenance_pitch
                          + maintenance_side_clearance) / 2,
                       interface_z_center
                       - maintenance_opening_height / 2])
                cube([wall + 2,
                      maintenance_pins[i] * maintenance_pitch
                      + maintenance_side_clearance,
                      maintenance_opening_height]);
    }
}

module antenna_cutouts() {
    if (antenna_holes_enabled) {
        if (antenna_layout == "rear_spread") {
            // Package B: five identical bulkheads on the rear wall. The
            // corner whips rotate outward; the centre three remain upright.
            for (x = antenna_rear_x)
                translate([x, outer_y + 1, antenna_z])
                    rotate([90, 0, 0])
                        cylinder(d = antenna_hole_diameter, h = wall + 2);
        } else {
            for (x = antenna_x)
                translate([x, outer_y + 1, antenna_z])
                    rotate([90, 0, 0])
                        cylinder(d = antenna_hole_diameter, h = wall + 2);
        }
    }
}

module antenna_feedline_anchors() {
    // Five real U-shaped tie bridges fused to the inner rear wall. Route each
    // pigtail through its bridge before the bulkhead to relieve connector load.
    if (antenna_holes_enabled)
        for (x = antenna_rear_x) {
            y0 = outer_y - wall - antenna_feed_anchor_depth + 0.4;
            z0 = split_z + 2.0;
            for (dx = [-antenna_feed_anchor_width / 2,
                       antenna_feed_anchor_width / 2 - 1.5])
                translate([x + dx, y0, z0])
                    cube([1.5, antenna_feed_anchor_depth,
                          antenna_feed_anchor_height]);
            translate([x - antenna_feed_anchor_width / 2,
                       y0,
                       z0 + antenna_feed_anchor_height])
                cube([antenna_feed_anchor_width,
                      antenna_feed_anchor_depth, 1.5]);
        }
}

module bottom() {
    difference() {
        union() {
            difference() {
                rounded_box([outer_x, outer_y, split_z], corner_radius);
                translate([wall, wall, floor_thickness])
                    rounded_box([inner_x, inner_y, split_z],
                                max(0.5, corner_radius - wall));
            }
            pcb_standoffs();
            translate([0, 0, floor_thickness])
                case_post_locations(split_z - lid_overlap - floor_thickness,
                                    case_screw_clearance);
        }
        // M2 countersinks enter from the exterior bottom and finish flush.
        for (x = [case_post_inset, outer_x - case_post_inset],
             y = [case_post_inset, outer_y - case_post_inset])
            translate([x, y, 0]) {
                // Exterior is z=0: large mouth outside, narrowing toward +z.
                translate([0, 0, -0.1])
                    cylinder(d1 = case_screw_head_diameter,
                             d2 = case_screw_clearance,
                             h = case_screw_head_depth + 0.1);
                // Explicit full-depth shank clearance prevents the floor/post
                // union from leaving a thin membrane above the countersink.
                translate([0, 0, -0.1])
                    cylinder(d = case_screw_clearance,
                             h = split_z - lid_overlap + 0.2);
            }
        foot_recesses();
        interface_cutouts();
        antenna_cutouts();
    }
}

module vent_slots() {
    for (ix = [0 : vent_columns - 1], iy = [0 : vent_rows - 1])
        translate([
            outer_x / 2 + (ix - (vent_columns - 1) / 2) * vent_pitch_x,
            outer_y / 2 + (iy - (vent_rows - 1) / 2) * vent_pitch_y,
            outer_z - top_thickness - 0.1
        ])
            hull()
                for (dx = [-vent_slot_length / 2, vent_slot_length / 2])
                    translate([dx, 0, 0])
                        cylinder(d = vent_slot_width,
                                 h = top_thickness + 0.2);
}

module brand_cut(line, size, y) {
    // Through-cut lettering with a retained horizontal stencil bridge.
    // The bridge prevents enclosed glyph counters becoming loose islands.
    translate([outer_x / 2, y, outer_z - top_thickness - 0.1])
        difference() {
            linear_extrude(height = top_thickness + 0.2)
                text(line, size = size, font = brand_font,
                     halign = "center", valign = "center");
            translate([-outer_x, -brand_bridge / 2, -0.1])
                cube([2 * outer_x, brand_bridge,
                      top_thickness + 0.4]);
        }
}

module top() {
    cap_h = outer_z - split_z;
    skirt_outer_x = inner_x - 2 * fit_clearance;
    skirt_outer_y = inner_y - 2 * fit_clearance;
    difference() {
        union() {
            // Main outer wall begins at the split plane, so it does not
            // occupy the same volume as the bottom outer wall.
            difference() {
                translate([0, 0, split_z])
                    rounded_box([outer_x, outer_y, cap_h], corner_radius);
                translate([wall, wall, split_z - 0.1])
                    rounded_box([
                        inner_x,
                        inner_y,
                        cap_h - top_thickness + 0.1
                    ], max(0.5, corner_radius - wall));
            }
            // Separate skirt fits inside the bottom cavity with 0.30 mm
            // clearance per side; only this feature crosses the split.
            translate([wall + fit_clearance, wall + fit_clearance,
                       split_z - lid_overlap])
                difference() {
                    rounded_box([skirt_outer_x, skirt_outer_y, lid_overlap],
                                max(0.5, corner_radius - wall
                                    - fit_clearance));
                    translate([lid_skirt_thickness, lid_skirt_thickness, -0.1])
                        rounded_box([
                            skirt_outer_x - 2 * lid_skirt_thickness,
                            skirt_outer_y - 2 * lid_skirt_thickness,
                            lid_overlap + 0.2
                        ], max(0.5, corner_radius - wall - fit_clearance
                              - lid_skirt_thickness));
                }
            // Reinforced upper bosses receive the M2 screw pilot.
            top_case_post_locations(
                split_z - lid_overlap,
                outer_z - top_thickness - (split_z - lid_overlap));
            antenna_feedline_anchors();
        }
        if (vent_enabled) vent_slots();
        if (brand_enabled) {
            brand_cut(brand_line1, brand_line1_size, brand_line1_y);
            brand_cut(brand_line2, brand_line2_size, brand_line2_y);
        }
        interface_cutouts();
        antenna_cutouts();
    }
}

module io_panel() {
    difference() {
        cube([io_panel_width, io_panel_thickness, io_panel_height]);
        for (o = io_openings)
            translate([o[0] - o[2] / 2, -0.1, o[1] - o[3] / 2])
                cube([o[2], io_panel_thickness + 0.2, o[3]]);
        if (dc_opening_enabled)
            translate([dc_panel_x, io_panel_thickness + 0.1, dc_panel_z])
                rotate([90, 0, 0])
                    cylinder(d = dc_opening_diameter,
                             h = io_panel_thickness + 0.2);
        if (reset_opening_enabled) {
            // Small full-depth tool hole, with a shallow exterior guide recess.
            translate([reset_panel_x, io_panel_thickness + 0.1, reset_panel_z])
                rotate([90, 0, 0])
                    cylinder(d = reset_tool_hole_diameter,
                             h = io_panel_thickness + 0.2);
            translate([reset_panel_x, reset_recess_depth, reset_panel_z])
                rotate([90, 0, 0])
                    cylinder(d1 = reset_tool_hole_diameter,
                             d2 = reset_recess_diameter,
                             h = reset_recess_depth + 0.1);
        }
    }
}

module assembly() {
    color("#33383d") bottom();
    color("#68727a")
        translate([0, 0, assembly_gap]) top();
    color("#333333")
        for (x = [bottom_foot_inset, outer_x - bottom_foot_inset],
             y = [bottom_foot_inset, outer_y - bottom_foot_inset])
            translate([x, y,
                       -(foot_pad_total_height - foot_pad_insert_height)])
                foot_pad();
}

if (part == "bottom") bottom();
else if (part == "top")
    translate([0, outer_y, outer_z])
        rotate([180, 0, 0]) top(); // print orientation: outer face upward
else if (part == "top_assembly") top(); // native closed-assembly coordinates
else if (part == "io_panel") io_panel();
else if (part == "foot_pad") foot_pad();
else assembly();
