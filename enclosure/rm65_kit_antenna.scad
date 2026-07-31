/*
  Antenna bulkhead bosses, cutouts and feedline anchors for RM65 KIT shell.
  Included by rm65_kit_enclosure.scad; depends on parent globals.
*/

// ========== 分区：公开 API ==========
function antenna_rear_enabled() =
    antenna_layout == "rear_spread"
    || antenna_layout == "rear_and_left";

function antenna_left_enabled() =
    antenna_layout == "rear_and_left"
    || antenna_layout == "left_spread";

module antenna_mount_bosses() {
    if (antenna_holes_enabled) {
        if (antenna_rear_enabled())
            for (x = antenna_rear_x)
                translate([x - antenna_mount_pad_width / 2,
                           outer_y - wall - antenna_mount_reinforce_depth,
                           antenna_z - antenna_mount_pad_height / 2])
                    cube([antenna_mount_pad_width,
                          antenna_mount_reinforce_depth + 0.20,
                          antenna_mount_pad_height]);
        if (antenna_left_enabled())
            for (y = antenna_left_y)
                translate([wall - 0.20,
                           y - antenna_mount_pad_width / 2,
                           antenna_z - antenna_mount_pad_height / 2])
                    cube([antenna_mount_reinforce_depth + 0.20,
                          antenna_mount_pad_width,
                          antenna_mount_pad_height]);
    }
}

module antenna_bulkhead_cutout_rear(x) {
    translate([x, outer_y + 1, antenna_z])
        rotate([90, 0, 0])
            cylinder(d = antenna_hole_diameter, h = wall + 2);
    // Exterior relief: effective panel thickness drops by 1 mm so more male
    // thread protrudes for the whip antenna knuckle.
    translate([x, outer_y + 0.05, antenna_z])
        rotate([90, 0, 0])
            cylinder(d = antenna_exterior_relief_diameter,
                     h = antenna_exterior_protrusion_relief + 0.05);
    translate([x,
               outer_y - wall
               - antenna_mount_reinforce_depth - 0.1,
               antenna_z])
        rotate([-90, 0, 0])
            cylinder(
                d = antenna_nut_across_flats / cos(30),
                h = antenna_nut_depth + 0.1,
                $fn = 6);
}

module antenna_bulkhead_cutout_left(y) {
    translate([-1, y, antenna_z])
        rotate([0, 90, 0])
            cylinder(d = antenna_hole_diameter, h = wall + 2);
    translate([-0.05, y, antenna_z])
        rotate([0, 90, 0])
            cylinder(d = antenna_exterior_relief_diameter,
                     h = antenna_exterior_protrusion_relief + 0.05);
    translate([wall + antenna_mount_reinforce_depth + 0.1,
               y, antenna_z])
        rotate([0, -90, 0])
            cylinder(
                d = antenna_nut_across_flats / cos(30),
                h = antenna_nut_depth + 0.1,
                $fn = 6);
}

module antenna_cutouts() {
    if (antenna_holes_enabled) {
        if (antenna_rear_enabled())
            for (x = antenna_rear_x)
                antenna_bulkhead_cutout_rear(x);
        if (antenna_left_enabled())
            for (y = antenna_left_y)
                antenna_bulkhead_cutout_left(y);
        if (antenna_layout == "legacy_row")
            for (x = antenna_x)
                translate([x, outer_y + 1, antenna_z])
                    rotate([90, 0, 0])
                        cylinder(d = antenna_hole_diameter, h = wall + 2);
    }
}

module antenna_feed_anchor_pair(anchor_x, anchor_y, along_y) {
    // U-shaped tie bridge; along_y=true places it on the rear wall.
    z0 = split_z + 2.0;
    if (along_y) {
        y0 = anchor_y;
        for (dx = [-antenna_feed_anchor_width / 2,
                   antenna_feed_anchor_width / 2 - 1.5])
            translate([anchor_x + dx, y0, z0])
                cube([1.5, antenna_feed_anchor_depth,
                      antenna_feed_anchor_height]);
        translate([anchor_x - antenna_feed_anchor_width / 2,
                   y0,
                   z0 + antenna_feed_anchor_height])
            cube([antenna_feed_anchor_width,
                  antenna_feed_anchor_depth, 1.5]);
    } else {
        x0 = anchor_x;
        for (dy = [-antenna_feed_anchor_width / 2,
                   antenna_feed_anchor_width / 2 - 1.5])
            translate([x0, anchor_y + dy, z0])
                cube([antenna_feed_anchor_depth, 1.5,
                      antenna_feed_anchor_height]);
        translate([x0,
                   anchor_y - antenna_feed_anchor_width / 2,
                   z0 + antenna_feed_anchor_height])
            cube([antenna_feed_anchor_depth,
                  antenna_feed_anchor_width, 1.5]);
    }
}

module antenna_feedline_anchors() {
    // U-bridges fused to the inner wall, laterally offset so each M6 bulkhead
    // can pass straight from inside to outside before the pigtail is dressed.
    if (antenna_holes_enabled) {
        if (antenna_rear_enabled())
            for (i = [0 : len(antenna_rear_x) - 1]) {
                x = antenna_rear_x[i];
                direction = i < 2 ? 1 : (i > 2 ? -1 : 1);
                antenna_feed_anchor_pair(
                    x + direction * antenna_feed_anchor_lateral_offset,
                    outer_y - wall - antenna_feed_anchor_depth + 0.4,
                    true);
            }
        if (antenna_left_enabled())
            for (i = [0 : len(antenna_left_y) - 1]) {
                y = antenna_left_y[i];
                direction = i < 2 ? 1 : (i > 2 ? -1 : 1);
                antenna_feed_anchor_pair(
                    wall + 0.4,
                    y + direction * antenna_feed_anchor_lateral_offset,
                    false);
            }
    }
}
