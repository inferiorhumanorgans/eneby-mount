// ImplicitCAD rendering options
$res = 0.125;

// OpenSCAD rendering options
// Highest quality
$fa = (1/8);
$fs = (1/25);

// Faster rendering
// $fa = (1/8);
// $fs = (1/4);

// Really fast rendering
// $fn = 70;

// Use the non-zero value for usable previews in OpenSCAD.  Unnecessary for rendering with either Implicit or OpenS.
// OPENSCAD_FUDGE = 0.1;
OPENSCAD_FUDGE = 0;

// Units are millimeters, but #8 wood screws are not a metric device
INCH_FACTOR = 25.4;

RADIUS = 0.5;
WALL_THICKNESS = 2.5;
BOLT_CLEARANCE = 0.75;

BASE_TOP_PADDING = 2;
BASE_HEIGHT = 40;
BASE_THICKNESS = 5;

// Needs to be big enough to clear the power cord
// 90 degree IEC whatever which is about 1" deep
STANDOFF_DEPTH = 28;

// M8
// https://www.mcmaster.com/mvC/Library/M1/20220203/CB36CF0F/91290A211_Black-Oxide%20Alloy%20Steel%20Socket%20Head%20ScrewX.GIF
// Head diameter for common bolts ranges from 13-16 mm.
SPEAKER_BOLT_DIAMETER = 8;
SPEAKER_BOLT_HEAD_DIAMETER = 13;

// #8 wood screw
// e.g https://www.mcmaster.com/mvC/Library/M1/20211129/B5D4B83E/90031A194_Phillips%20Flat%20Head%20Screws%20for%20WoodX.GIF
WALL_SCREW_DIAMETER = 0.164 * INCH_FACTOR;
WALL_SCREW_HEAD_DIAMETER = 0.363 * INCH_FACTOR;

module bracket() {
    difference(r = RADIUS) {
        height=BASE_HEIGHT + BASE_TOP_PADDING;
        union(r = RADIUS) {
            speaker_diameter = SPEAKER_BOLT_HEAD_DIAMETER + (WALL_THICKNESS * 2) + BOLT_CLEARANCE;
            wall_diameter = WALL_SCREW_HEAD_DIAMETER + (WALL_THICKNESS * 2) + BOLT_CLEARANCE;

            color("blue")
            linear_extrude(BASE_THICKNESS, r = RADIUS) {
                union() {
                    translate([0, 0]) {
                        circle(d = speaker_diameter);
                    }

                    translate([0, height]) {
                        circle(d = wall_diameter);
                    }

                    polygon([
                        [-(speaker_diameter / 2), 0],
                        [(speaker_diameter / 2), 0],
                        [(wall_diameter / 2), height],
                        [-(wall_diameter / 2), height]
                    ]);
                }
            }

            color("lightblue")
            translate([0, 0, RADIUS]) {
                difference() {
                    linear_extrude(STANDOFF_DEPTH - RADIUS, r = RADIUS) {
                        circle(d = speaker_diameter);
                    }
                    translate([0, 0, STANDOFF_DEPTH - WALL_THICKNESS - RADIUS + OPENSCAD_FUDGE]) {
                        cylinder(d = SPEAKER_BOLT_DIAMETER + BOLT_CLEARANCE, h = WALL_THICKNESS);
                    }
                }
            }
        }

        color("cyan") {
            translate([0, 0, -OPENSCAD_FUDGE]) {
                cylinder(d = SPEAKER_BOLT_HEAD_DIAMETER + BOLT_CLEARANCE, h = STANDOFF_DEPTH - WALL_THICKNESS + RADIUS);
            }
        }

    }
}
module keyhole() {
    upper_layer_thickness = 2.25;
    union(r=RADIUS) {
        translate([0, 0, BASE_THICKNESS - upper_layer_thickness + OPENSCAD_FUDGE]) {
            color("red") {
                // Allow for extra depth from the radiused edge
                translate([0, 0, OPENSCAD_FUDGE])
                linear_extrude(upper_layer_thickness) {
                    translate([0, BASE_HEIGHT + BASE_TOP_PADDING]) {
                        union() {
                            circle(d=WALL_SCREW_HEAD_DIAMETER);
                            translate([-WALL_SCREW_HEAD_DIAMETER / 2, -WALL_SCREW_HEAD_DIAMETER]) {
                                polygon([
                                    [0, 0],
                                    [WALL_SCREW_HEAD_DIAMETER, 0],
                                    [WALL_SCREW_HEAD_DIAMETER, WALL_SCREW_HEAD_DIAMETER],
                                    [0, WALL_SCREW_HEAD_DIAMETER]
                                ]);
                            }
                            translate([0, -WALL_SCREW_HEAD_DIAMETER]) {
                                circle(d = WALL_SCREW_HEAD_DIAMETER);
                            }
                        }
                    }
                }
            }
        }
        color("orange") {
            translate([0, 0, -OPENSCAD_FUDGE])
            linear_extrude(BASE_THICKNESS) {
                union() {
                    translate([0, BASE_HEIGHT + BASE_TOP_PADDING - WALL_SCREW_HEAD_DIAMETER]) {
                        circle(d = WALL_SCREW_HEAD_DIAMETER);
                    }
                    translate([0, BASE_HEIGHT + BASE_TOP_PADDING + (RADIUS/2)]) {
                        circle(d = WALL_SCREW_DIAMETER);
                        translate([-WALL_SCREW_DIAMETER / 2, -WALL_SCREW_HEAD_DIAMETER + RADIUS]) {
                            polygon([
                                [0, 0],
                                [0, WALL_SCREW_HEAD_DIAMETER - RADIUS],
                                [WALL_SCREW_DIAMETER, WALL_SCREW_HEAD_DIAMETER - RADIUS],
                                [WALL_SCREW_DIAMETER, 0]
                            ]);
                        }
                    }
                }
            }
        }
        color("green") {
            translate([0, 0, OPENSCAD_FUDGE])
            linear_extrude(BASE_THICKNESS) {
                translate([0, BASE_HEIGHT + BASE_TOP_PADDING - WALL_SCREW_HEAD_DIAMETER]) {
                    circle(d = WALL_SCREW_HEAD_DIAMETER);
                }
            }
        }
    }
}

difference(r = RADIUS) {
    bracket();
    keyhole();
}
