// For ImplicitCAD
$res=0.125;

// For OpenSCAD, should give fast enough previews but fairly slow renders
$fa=(1/8);
$fs=(1/25);

// $fa=(1/4);
// $fs=(1/12);

// $fn=70;

RADIUS=0.5;
WALL_THICKNESS = 2.5;
FUDGE = 0.75;

BASE_TOP_PADDING = 2;
BASE_HEIGHT = 40;
BASE_THICKNESS = 5;

// Needs to be big enough to clear the power cord
// 90 degree IEC whatever
STANDOFF_DEPTH = 20;

// M8
// https://www.mcmaster.com/mvC/Library/M1/20220203/CB36CF0F/91290A211_Black-Oxide%20Alloy%20Steel%20Socket%20Head%20ScrewX.GIF
// Head diameter for common bolts ranges from 13-16 mm.
SPEAKER_BOLT_DIAMETER = 8;
SPEAKER_BOLT_HEAD_DIAMETER = 13;

// #8 wood screw
// e.g https://www.mcmaster.com/mvC/Library/M1/20211129/B5D4B83E/90031A194_Phillips%20Flat%20Head%20Screws%20for%20WoodX.GIF
WALL_SCREW_DIAMETER = (0.164 * 25.4);
WALL_SCREW_HEAD_DIAMETER = (0.363 * 25.4);

module bracket() {
    difference(r=RADIUS) {
        height=BASE_HEIGHT + BASE_TOP_PADDING;
        union(r=RADIUS) {
            speaker_diameter = SPEAKER_BOLT_HEAD_DIAMETER + (WALL_THICKNESS * 2) + FUDGE;
            wall_diameter = WALL_SCREW_HEAD_DIAMETER + (WALL_THICKNESS * 2) + FUDGE;

            linear_extrude(BASE_THICKNESS, r=RADIUS) {

                union() {

                    translate([0, 0]) {
                        circle(d = speaker_diameter);
                    }

                    translate([0, height]) {
                        circle(d = wall_diameter);
                    }

                    polygon([
                        [-(speaker_diameter/2), 0],
                        [(speaker_diameter/2), 0],
                        [(wall_diameter/2), height],
                        [-(wall_diameter/2), height]
                    ]);
                }
            }

            translate([0, 0, RADIUS]) {
                difference() {
                    linear_extrude(STANDOFF_DEPTH, r=RADIUS) {
                        circle(d = speaker_diameter);
                    }
                    translate([0, 0, STANDOFF_DEPTH - WALL_THICKNESS - 0.1])
                    cylinder(d = SPEAKER_BOLT_DIAMETER + FUDGE, h=WALL_THICKNESS + 0.2);
                }
            }
        }

        cylinder(d = SPEAKER_BOLT_HEAD_DIAMETER + FUDGE, h=STANDOFF_DEPTH - WALL_THICKNESS + RADIUS);

    }
}
module keyhole() {
    upper_layer_thickness = 2.25;
    union(r=RADIUS/2) {
        translate([0,0, BASE_THICKNESS - upper_layer_thickness]) {
            linear_extrude(upper_layer_thickness) {
                translate([0, BASE_HEIGHT + BASE_TOP_PADDING]) {
                    circle(d=WALL_SCREW_HEAD_DIAMETER);
                    translate([-WALL_SCREW_HEAD_DIAMETER/2, -WALL_SCREW_HEAD_DIAMETER])
                    polygon([
                        [0, 0],
                        [WALL_SCREW_HEAD_DIAMETER, 0],
                        [WALL_SCREW_HEAD_DIAMETER, WALL_SCREW_HEAD_DIAMETER],
                        [0, WALL_SCREW_HEAD_DIAMETER]
                    ]);
                    translate([0, -WALL_SCREW_HEAD_DIAMETER]) {
                        circle(d=WALL_SCREW_HEAD_DIAMETER);
                    }
                }
            }
        }
        linear_extrude(BASE_THICKNESS) {
            translate([0, BASE_HEIGHT + BASE_TOP_PADDING - WALL_SCREW_HEAD_DIAMETER]) {
                circle(d=WALL_SCREW_HEAD_DIAMETER);
            }
            translate([0, BASE_HEIGHT + BASE_TOP_PADDING + ((WALL_SCREW_HEAD_DIAMETER-WALL_SCREW_DIAMETER)/2)]) {
                circle(d=WALL_SCREW_DIAMETER);
                translate([-WALL_SCREW_DIAMETER/2, -WALL_SCREW_HEAD_DIAMETER])
                polygon([
                    [0, 0],
                    [0, WALL_SCREW_HEAD_DIAMETER],
                    [WALL_SCREW_DIAMETER, WALL_SCREW_HEAD_DIAMETER],
                    [WALL_SCREW_DIAMETER, 0]
                ]);
            }
        }
        linear_extrude(BASE_THICKNESS) {
            translate([0, BASE_HEIGHT + BASE_TOP_PADDING - WALL_SCREW_HEAD_DIAMETER]) {
                circle(d=WALL_SCREW_HEAD_DIAMETER);
            }
        }
    }
}
difference(r=RADIUS/2) {
    bracket();
    keyhole();
}
