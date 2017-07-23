PRECISION = 50;
THICKNESS = 4;

CAM_DISTANCE_FROM_BASE = 15;
CAM_WIDTH = 36;
CAM_HEIGHT = 36;
CAM_HOLE_SPACING = 29;
CAM_HOLE_D = 3;
CAM_HOLE_R = CAM_HOLE_D/2;
CAM_TOTAL_HEIGHT = CAM_DISTANCE_FROM_BASE + CAM_HEIGHT;
CAM_HOLE_OFFSET = (CAM_WIDTH - CAM_HOLE_SPACING)/2;
//CAM_HEIGHT = OFFSET_CENTER/2 + CAM_WIDTH/2;
//CAM_HOLE_POSITION = THICKNESS + CAM_HEIGHT - CAM_WIDTH;

LENS_CENTER_FROM_BASE = 33;
LENS_D = 28.25;
LENS_R = LENS_D/2;
DISTANCE_LENS = 27;
LENS_BUFFER = 5;
LENS_TOTAL_HEIGHT = LENS_CENTER_FROM_BASE + LENS_R + LENS_BUFFER;

BRACE_LENGTH = 18;
BRACE_HEIGHT = 26;
BRACE_THICKNESS = 5;
BRACE_OFFSET = 10;

BASE_LENGTH = BRACE_LENGTH + THICKNESS + DISTANCE_LENS + THICKNESS;
BASE_WIDTH = CAM_WIDTH;
BASE_HOLE_D = 4;
BASE_HOLE_R = BASE_HOLE_D/2;
BASE_POS0 = 7;
BASE_POS1 = 27;
BASE_POS2 = 43;
BASE_HOLD_OFFSET = 5;

module prism(l, w, h){
   polyhedron(
       points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
       faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );   
}

module hole(r){
    rotate ([0,0,90]) {
        cylinder (h=10, r=r, center=true, $fn=PRECISION);
    }
}

// Base
difference() {
    cube([BASE_LENGTH, BASE_WIDTH, THICKNESS]);
    translate([BASE_POS0, BASE_WIDTH/2,0]){
        hole(BASE_HOLE_R);
    }
    translate([BASE_POS1, BASE_HOLD_OFFSET,0]){
        hole(BASE_HOLE_R);
    }
    translate([BASE_POS1, BASE_WIDTH-BASE_HOLD_OFFSET,0]){
        hole(BASE_HOLE_R);
    }
    translate([BASE_POS2, BASE_HOLD_OFFSET,0]){
        hole(BASE_HOLE_R);
    }
    translate([BASE_POS2, BASE_WIDTH-BASE_HOLD_OFFSET,0]){
        hole(BASE_HOLE_R);
    }
}

translate([THICKNESS,0,0]){
    // Braces
    rotate([0,0,-90]){
        translate([ 0, -THICKNESS, THICKNESS]){
            translate([ -BRACE_OFFSET - BRACE_THICKNESS/2, 0, 0])
            prism( BRACE_THICKNESS, BRACE_LENGTH, BRACE_HEIGHT );
        }

        translate([-CAM_WIDTH, -THICKNESS, THICKNESS]){
            translate([ BRACE_OFFSET - BRACE_THICKNESS/2, 0, 0])
            prism( BRACE_THICKNESS, BRACE_LENGTH, BRACE_HEIGHT );
        }
    }
    
    // Camera plate
    translate([BRACE_LENGTH, 0, 0]) {
        rotate([0,-90,0]){
            difference(){
                cube([CAM_TOTAL_HEIGHT, CAM_WIDTH, THICKNESS]);
                translate([CAM_HOLE_OFFSET + CAM_DISTANCE_FROM_BASE, CAM_HOLE_OFFSET, 0]){
                    hole(CAM_HOLE_R);
                    
                    translate([CAM_HOLE_SPACING, 0, 0])
                    hole(CAM_HOLE_R);
                    
                    translate([0, CAM_HOLE_SPACING, 0])
                    hole(CAM_HOLE_R);

                    translate([CAM_HOLE_SPACING, CAM_HOLE_SPACING, 0])
                    hole(CAM_HOLE_R);
                }
            }
        }
    }

    // Lens plate
    translate([BRACE_LENGTH + DISTANCE_LENS + LENS_BUFFER, 0, 0]) {
        rotate([0,-90,0]){
            difference(){
            cube([LENS_TOTAL_HEIGHT, CAM_WIDTH, THICKNESS]);
                translate([LENS_CENTER_FROM_BASE, CAM_WIDTH/2, 0]){
                    hole(LENS_R);
                    translate([-LENS_R, 0, -4]){
                    cube([LENS_D, LENS_D, 10]);
                    }
                }
            }
        }
    }
}