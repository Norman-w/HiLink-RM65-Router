/*
  HiLink RM65 KIT enclosure — measured HLK-AX3000-KIT V1.0 revision

  XY data is taken from the official 2024-12-05 PcbDoc. Interface Z and
  protrusion values are measured from the delivered V1.0 board. Small FDM
  fit allowances remain printer/material dependent and should be verified
  with the supplied test-coupon workflow before a long final print.
*/

// ========== 分区：导入/依赖 ==========
// Module bodies resolve parent globals at call time, so includes may precede
// the parameter block.
include <rm65_kit_antenna.scad>
include <rm65_kit_shell_parts.scad>

// ========== 分区：常量/配置 ==========
// Export target: "bottom", "top", "top_assembly", "foot_pad", or "assembly".
part = "assembly";

pcb_x = 152.0038;              // official PcbDoc outline
pcb_y = 109.0000;
pcb_thickness = 1.6;
wall = 2.4;
floor_thickness = 2.4;
top_thickness = 2.4;
pcb_side_clearance = 3.5;      // front/right plug tunnel; clears PCB M2 bosses
// Left bay: IPX pigtails are too short for an all-rear layout; Dupont/header
// side (opposite RJ45 mouths) gets its own inside-out bulkhead service bay.
left_service_extension = 20.0;
rear_service_extension = 20.0;// keep rear bay; original rear ports remain usable
clearance_below_pcb = 4.0;     // 2.5 mm solder pins + 1.5 mm safety margin
clearance_above_pcb = 19.5;    // 17 mm heatsink + 2.5 mm safety margin

// Official PcbDoc J8/J5/J6/J7 mounting-pad centres, relative to the board
// outline lower-left. The plated physical holes are 125 mil = 3.175 mm.
pcb_holes_enabled = true;
pcb_holes = [
    [4.0008, 4.0053],          // J8 lower-left
    [3.9879, 105.0016],        // J5 upper-left
    [148.3238, 4.0000],        // J6 lower-right
    [148.3238, 105.0000]       // J7 upper-right
];
pcb_mount_hole_diameter = 3.175;
pcb_screw_nominal = 2.0;       // user-selected M2 PCB fixing
pcb_pilot_diameter = 1.7;      // M2 self-tapping pilot in printed boss
pcb_standoff_outer_diameter = 6.0;
pcb_standoff_height = clearance_below_pcb;
pcb_guide_diameter = 2.85;     // centres the 3.175 mm PCB hole
pcb_guide_height = 1.0;
pcb_screw_recommendation = "M2x6 pan-head, self-tapping into 1.7 mm pilot";

// External plug envelopes retained as assembly documentation.
dc_plug_grip_diameter = 18.0;  // external hand/finger access envelope
dc_cable_bend_clearance = 35.0;// free space outside panel; documentation only

// ---------- PCB-DOC XY INTERFACE CUTOUT CANDIDATE ----------
// XY is official PcbDoc data. Z is derived from the measured board using the
// PCB top surface as datum. Each interface has its own height; there is no
// longer one guessed global Z centre.
interface_cutouts_enabled = true;
pcb_bottom_z = floor_thickness + clearance_below_pcb;
pcb_top_z = pcb_bottom_z + pcb_thickness;

rj45_y = [15.64, 30.89, 46.14, 61.39, 75.86, 91.74];
rj45_port_width = 14.6;
rj45_opening_y0 = rj45_y[0] - rj45_port_width / 2;
rj45_opening_y1 = rj45_y[len(rj45_y) - 1] + rj45_port_width / 2;
rj45_opening_height = 14.6;    // 13.8 measured + 0.4 mm each side
rj45_z_center = pcb_top_z + 13.8 / 2;
rj45_protrusion = 2.0;

switch_x = [11.29, 22.03];     // GPIO_RST, SYS_RST
switch_labels = ["GPIO_RST", "SYS_RST"];
switch_y = 1.94;               // component reference; front-wall hole uses X
switch_tool_diameter = 3.2;
switch_recess_diameter = 6.0;
switch_recess_depth = 1.2;
switch_z_center = pcb_top_z + 4.5 / 2;
switch_protrusion = 0.5;
usb_reference_x = 38.40;      // official footprint/model insertion origin, not mouth centre
usb_mouth_offset_x = 12.60;   // delivered board: mouth spans X=43.5..58.5, centre=51.0
usb_x = usb_reference_x + usb_mouth_offset_x;
usb_y = -2.48;                 // component reference; front-wall hole uses X
usb_opening_width = 15.6;
usb_opening_height = 8.3;      // measured 0.5..8.0 + 0.4 mm vertical clearance
usb_z_center = pcb_top_z + (0.5 + 8.0) / 2;
usb_protrusion = 2.5;
dc_x = 99.95;
dc_y = 6.25;                   // component reference; front-wall hole uses X
dc_shell_opening_diameter = 11.4;
dc_z_center = pcb_top_z + 10.8 / 2;
dc_protrusion = 1.2;

// USB-TTL Type-C on the left wall. The PcbDoc reference sits at one end of
// the 8.636 mm connector outline, so use the outline/mouth centre instead.
typec_reference_y = 19.1213;
typec_mouth_offset_y = -4.3540;
typec_y = typec_reference_y + typec_mouth_offset_y;
typec_x = 5.9372;
typec_opening_width = 10.0;    // along PCB Y, includes FDM clearance
typec_opening_height = 3.8;    // measured 3.0 mm + 0.4 mm each side
typec_z_center = pcb_top_z + 3.0 / 2;
typec_protrusion = 0.8;

led_x = [15.01, 21.18, 27.34, 33.51, 39.67,
         45.84, 52.07, 58.23, 64.40];
led_y = 102.06;                // component reference; rear-wall hole uses X
led_shell_hole_diameter = 3.6;
led_z_center = pcb_top_z + 1.5;
led_guide_outer_diameter = 5.4;
led_guide_lower_z = pcb_top_z + 5.0; // stays above the photographed LED domes

// Package-B M6 bulkhead antenna connector (~M8 panel idiom / ~8 mm-AF nut).
// Printed inner thickening captures the hex nut; exterior stays circular.
antenna_holes_enabled = true;
antenna_hole_diameter = 6.5;   // M6 thread + 0.5 mm FDM assembly allowance
// Ten M6 holes remain (rear 5 + left 5). Only five get whips; see RF plan below.
antenna_layout = "rear_and_left";
antenna_z = 22.0;              // nut envelope stays clear of roof and split
antenna_pivot_keepout_radius = 12.0; // mechanical sweep only; not RF spacing
antenna_x = [22, 49, 76, 103, 130]; // legacy rear-row option
antenna_nut_across_flats = 8.3;
antenna_nut_depth = 3.2;
antenna_insertion_envelope_length = 23.0; // inside-out service envelope
antenna_insertion_envelope_diameter = 10.0;
antenna_mount_pad_width = 13.0;
antenna_mount_pad_height = 12.0; // lower edge lands exactly on the split plane
antenna_mount_reinforce_depth = 3.4;
antenna_feed_anchor_width = 8.0;
antenna_feed_anchor_depth = 3.0;
antenna_feed_anchor_height = 6.0;
antenna_feed_anchor_slot = 3.0;
antenna_feed_anchor_lateral_offset = 10.0; // keeps the insertion axis open
// Exterior counterbore so more male thread sticks out for whip antennas.
antenna_exterior_protrusion_relief = 1.0;
antenna_exterior_relief_diameter = 9.0;

// ----- RF plan (2.4G×2 + 5G×3), IPX reach: rear-left 3 + any left 5 -----
// Free-space targets: λ24≈125 mm (λ/2≈62.5); λ5≈55 mm @5.5 GHz (λ/2≈27.5).
// 2.4G on orthogonal walls at max reach; 5G triad with ≥λ/2 mutual spacing.
antenna_rf_lambda_24 = 125.0;
antenna_rf_lambda_5 = 55.0;
antenna_whip_length = 85.0;    // preview / keepout documentation only

// ---------- PRINT / FIT PARAMETERS ----------
// PCB shifts right by left_service_extension; left bay is empty service volume.
pcb_origin_x = wall + left_service_extension + pcb_side_clearance;
pcb_origin_y = wall + pcb_side_clearance;
corner_radius = 4.0;
lid_overlap = 5.0;
fit_clearance = 0.30;         // per side; tune for the printer/material
lid_skirt_thickness = 1.2;    // inner skirt; avoids overlapping outer walls
lid_skirt_root_height = 4.0;  // gradual ramp; avoids a brittle 90-degree neck
lid_skirt_wall_overlap = 0.60;// outward ramp embeds into the cap side wall
interface_cut_depth = wall + fit_clearance + lid_skirt_thickness + 2.0;
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
case_post_inset = 4.0;         // corner-wall post, clear of official PCB bosses

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
brand_line2 = "Router V1.2.0";
brand_line1_size = 11.5;       // larger strokes for reliable FDM through-cuts
brand_line2_size = 7.2;
// Front/top band (low Y, above the USB/DC wall); clear of centre vent field.
brand_line1_y = 28.0;
brand_line2_y = 16.0;

// Preview-only separation. Ignored by individual STL exports.
assembly_gap = 0.0;
$fn = 48;

inner_x = pcb_x + 2 * pcb_side_clearance + left_service_extension;
inner_y = pcb_y + 2 * pcb_side_clearance + rear_service_extension;
outer_x = inner_x + 2 * wall;
outer_y = inner_y + 2 * wall;
antenna_core_outer_x = pcb_x + 2 * pcb_side_clearance + 2 * wall;
// Rear X: left three = active RF (IPX-reachable); right two = spare empty seats.
antenna_rear_x = [
    30.0,   // 5G-A  active
    65.0,   // 5G-B  active
    100.0,  // 2.4G-B active (farthest rear seat IPX can reach)
    left_service_extension + antenna_core_outer_x - 45, // spare — do not mount
    left_service_extension + antenna_core_outer_x - 12  // spare — do not mount
];
// Left Y: Type-C clear (≥34). Active at 34 (2.4G-A) and 90 (5G-C); others spare.
antenna_left_y = [34.0, 55.0, 72.0, 90.0, 128.0];
// Active whip plan: [wall, coord, band, tilt_from_vertical_deg, fan_deg]
// wall 0=left (−X), 1=rear (+Y). Practical home-router look: mostly upright;
// only corner seats get a mild outward fan. Spacing does the RF work, not tilt.
antenna_active = [
    [0, 34.0,  24, 0,   0],  // 2.4G-A: left-front, upright
    [1, 100.0, 24, 0,   0],  // 2.4G-B: rear, upright (orthogonal wall vs A)
    [1,  30.0,  5, 0, -20],  // 5G-A: rear-left, slight outward fan only
    [1,  65.0,  5, 0,   0],  // 5G-B: rear, upright
    [0,  90.0,  5, 0,   0]   // 5G-C: left, upright
];
// NORMAN centred over the PCB; version right-aligned with a real right inset
// so glyph ink stays inside the top face (not clipped by the outer edge).
brand_line1_x = pcb_origin_x + pcb_x / 2;
brand_line2_halign = "right";
brand_line2_right_inset = 20.0;
brand_line2_x = outer_x - brand_line2_right_inset;
split_z = floor_thickness + clearance_below_pcb + pcb_thickness + 8.0;
outer_z = floor_thickness + clearance_below_pcb + pcb_thickness
          + clearance_above_pcb + top_thickness;
// Type-C must tunnel through the new left service bay to the PCB mouth.
typec_tunnel_depth = pcb_origin_x + typec_x + typec_protrusion + 1.0;

// Compile-time assembly checks for the delivered M6 bulkheads. The worst-case
// rear antenna at X=45 mm is nearly aligned with the LED row, so its straight
// insertion path is governed by the rear face of the guide sleeve.
rear_inner_wall_y = outer_y - wall;
led_guide_rear_edge_y = pcb_origin_y + led_y
                        + led_guide_outer_diameter / 2;
antenna_service_clearance = rear_inner_wall_y - led_guide_rear_edge_y;
left_bay_clearance = pcb_origin_x - wall;
antenna_nut_corner_radius = antenna_nut_across_flats / (2 * cos(30));
antenna_anchor_axis_clearance = antenna_feed_anchor_lateral_offset
                                - antenna_feed_anchor_width / 2
                                - antenna_insertion_envelope_diameter / 2;
assert(antenna_service_clearance >= antenna_insertion_envelope_length,
       "Rear bay is too short for inside-out antenna insertion");
assert(left_bay_clearance >= antenna_insertion_envelope_length,
       "Left bay is too short for inside-out antenna insertion");
assert(antenna_anchor_axis_clearance >= 0.8,
       "Feedline bridge intrudes into the antenna insertion corridor");
assert(antenna_z - antenna_nut_corner_radius > split_z,
       "Antenna nut pocket intersects the lower shell");
assert(antenna_z + antenna_nut_corner_radius < outer_z - top_thickness,
       "Antenna nut pocket intersects the roof");
assert(antenna_z - antenna_mount_pad_height / 2 >= split_z,
       "Antenna reinforcement pad intersects the lower shell");
assert(antenna_exterior_protrusion_relief < wall - 0.6,
       "Exterior antenna relief would leave a paper-thin panel");
assert(wall - antenna_exterior_protrusion_relief >= 1.2,
       "Remaining antenna panel thickness below 1.2 mm");

// Active seat XY (outer-face centres) and RF spacing checks.
antenna_p_24a = [0, antenna_left_y[0]];
antenna_p_24b = [antenna_rear_x[2], outer_y];
antenna_p_5a = [antenna_rear_x[0], outer_y];
antenna_p_5b = [antenna_rear_x[1], outer_y];
antenna_p_5c = [0, antenna_left_y[3]];
function antenna_dist(a, b) =
    sqrt((a[0] - b[0]) * (a[0] - b[0]) + (a[1] - b[1]) * (a[1] - b[1]));
antenna_d_24 = antenna_dist(antenna_p_24a, antenna_p_24b);
antenna_d_5ab = antenna_dist(antenna_p_5a, antenna_p_5b);
antenna_d_5ac = antenna_dist(antenna_p_5a, antenna_p_5c);
antenna_d_5bc = antenna_dist(antenna_p_5b, antenna_p_5c);
assert(antenna_d_24 >= antenna_rf_lambda_24 / 2,
       "2.4G pair closer than λ/2");
assert(antenna_d_5ab >= antenna_rf_lambda_5 / 2,
       "5G A–B closer than λ/2");
assert(antenna_d_5ac >= antenna_rf_lambda_5 / 2,
       "5G A–C closer than λ/2");
assert(antenna_d_5bc >= antenna_rf_lambda_5 / 2,
       "5G B–C closer than λ/2");
assert(antenna_rear_x[2] <= 105,
       "2.4G-B rear seat beyond stated IPX reach band");

// ========== 分区：公开 API ==========
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
            translate([0, 0, floor_thickness - 0.20])
                case_post_locations(split_z - floor_thickness + 0.20,
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

module brand_cut(line, size, x, y, halign = "center") {
    // Through-cut lettering with a retained horizontal stencil bridge.
    // The bridge prevents enclosed glyph counters becoming loose islands.
    translate([x, y, outer_z - top_thickness - 0.1])
        difference() {
            linear_extrude(height = top_thickness + 0.2)
                text(line, size = size, font = brand_font,
                     halign = halign, valign = "center");
            translate([-outer_x, -brand_bridge / 2, -0.1])
                cube([2 * outer_x, brand_bridge,
                      top_thickness + 0.4]);
        }
}

module lid_skirt_root_gusset(skirt_outer_x, skirt_outer_y) {
    // Continuous tapered ring. At the split plane it matches the existing
    // 1.2 mm skirt; over 4 mm its outer face ramps into the cap wall while the
    // inner face stays vertical. No wedge tip projects into the enclosure.
    // The skirt's outside fit envelope is unchanged below the split.
    lower_outer_origin = wall + fit_clearance;
    lower_inner_origin = lower_outer_origin + lid_skirt_thickness;
    upper_outer_origin = wall - lid_skirt_wall_overlap;
    upper_inner_origin = lower_inner_origin;
    upper_outer_x = inner_x + 2 * lid_skirt_wall_overlap;
    upper_outer_y = inner_y + 2 * lid_skirt_wall_overlap;
    lower_inner_x = skirt_outer_x - 2 * lid_skirt_thickness;
    lower_inner_y = skirt_outer_y - 2 * lid_skirt_thickness;
    upper_inner_x = outer_x - 2 * upper_inner_origin;
    upper_inner_y = outer_y - 2 * upper_inner_origin;
    slice_h = 0.20;

    difference() {
        hull() {
            translate([lower_outer_origin, lower_outer_origin, split_z])
                rounded_box([skirt_outer_x, skirt_outer_y, slice_h],
                            max(0.5, corner_radius - lower_outer_origin));
            translate([upper_outer_origin, upper_outer_origin,
                       split_z + lid_skirt_root_height - slice_h])
                rounded_box([upper_outer_x, upper_outer_y, slice_h],
                            max(0.5, corner_radius - upper_outer_origin));
        }
        hull() {
            translate([lower_inner_origin, lower_inner_origin,
                       split_z - 0.10])
                rounded_box([lower_inner_x, lower_inner_y, slice_h + 0.20],
                            max(0.5, corner_radius - lower_inner_origin));
            translate([upper_inner_origin, upper_inner_origin,
                       split_z + lid_skirt_root_height - slice_h - 0.10])
                rounded_box([upper_inner_x, upper_inner_y, slice_h + 0.30],
                            max(0.5, corner_radius - upper_inner_origin));
        }
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
                    rounded_box([skirt_outer_x, skirt_outer_y,
                                 lid_overlap + 0.50],
                                max(0.5, corner_radius - wall
                                    - fit_clearance));
                    translate([lid_skirt_thickness, lid_skirt_thickness, -0.1])
                        rounded_box([
                            skirt_outer_x - 2 * lid_skirt_thickness,
                            skirt_outer_y - 2 * lid_skirt_thickness,
                            lid_overlap + 0.70
                        ], max(0.5, corner_radius - wall - fit_clearance
                              - lid_skirt_thickness));
                    // Bottom through-posts reach the split plane. Four local
                    // reliefs give the skirt the same 0.30 mm assembly fit and
                    // prevent a hidden corner collision during lid insertion.
                    for (x = [case_post_inset, outer_x - case_post_inset],
                         y = [case_post_inset, outer_y - case_post_inset])
                        translate([
                            x - (wall + fit_clearance),
                            y - (wall + fit_clearance),
                            -0.1
                        ])
                            cylinder(
                                d = case_post_outer_diameter
                                    + 2 * fit_clearance,
                                h = lid_overlap + 0.70);
                }
            // A short shoulder above the split bridges the 0.30 mm fit gap
            // between the inner skirt and the outer top wall. It never enters
            // the bottom shell, so the real closed-assembly datum is unchanged.
            translate([wall, wall, split_z])
                difference() {
                    rounded_box([inner_x, inner_y, 0.50],
                                max(0.5, corner_radius - wall));
                    translate([fit_clearance + lid_skirt_thickness,
                               fit_clearance + lid_skirt_thickness, -0.1])
                        rounded_box([
                            inner_x - 2 * (fit_clearance
                                           + lid_skirt_thickness),
                            inner_y - 2 * (fit_clearance
                                           + lid_skirt_thickness),
                            0.70
                        ], max(0.5, corner_radius - wall - fit_clearance
                              - lid_skirt_thickness));
                }
            lid_skirt_root_gusset(skirt_outer_x, skirt_outer_y);
            // Reinforced upper bosses receive the M2 screw pilot.
            top_case_post_locations(
                split_z,
                outer_z - top_thickness - split_z + 0.20);
            antenna_mount_bosses();
            antenna_feedline_anchors();
            led_lightpipe_guides();
        }
        if (vent_enabled) vent_slots();
        if (brand_enabled) {
            brand_cut(brand_line1, brand_line1_size,
                      brand_line1_x, brand_line1_y);
            brand_cut(brand_line2, brand_line2_size,
                      brand_line2_x, brand_line2_y, brand_line2_halign);
        }
        interface_cutouts();
        antenna_cutouts();
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
else if (part == "foot_pad") foot_pad();
else if (part == "assembly") assembly();
