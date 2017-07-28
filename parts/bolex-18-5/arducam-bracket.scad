$fn=50;
THICKNESS = 4;

CAM_DISTANCE_FROM_BASE = 15;
CAM_WIDTH = 36;
CAM_HEIGHT = 36;
CAM_HOLE_SPACING = 29;
CAM_HOLE_D = 3;
CAM_HOLE_R = CAM_HOLE_D/2;
CAM_TOTAL_HEIGHT = CAM_DISTANCE_FROM_BASE + CAM_HEIGHT;
CAM_HOLE_OFFSET = (CAM_WIDTH - CAM_HOLE_SPACING)/2;

// The back of the Arducam has two screw heads sticking out.
// These screws hold the lens mount in place.
CAM_SCREW_HOLES_DISTANCE = 9;
CAM_SCREW_HOLES_R = 2;

BRACE_LENGTH = 18;
BRACE_HEIGHT = 26;
BRACE_THICKNESS = 5;
BRACE_OFFSET = 10;

LENS_CENTER_FROM_BASE = 33;
LENS_D = 28.25;
LENS_R = LENS_D/2;
DISTANCE_LENS = 27;

LENS_SUPPORT_THICKNESS = 6;
LENS_SUPPORT_POSITION = BRACE_LENGTH + LENS_SUPPORT_THICKNESS + DISTANCE_LENS;
LENS_SUPPORT_BUFFER = 4;
LENS_SUPPORT_CHOP = 10;

BASE_BUFFER = 6;
BASE_LENGTH = BRACE_LENGTH + THICKNESS + DISTANCE_LENS + LENS_SUPPORT_THICKNESS;
BASE_WIDTH = CAM_WIDTH + BASE_BUFFER*2;

module prism(l, w, h){
   polyhedron(
       points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
       faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );   
}

module hole(r){
    rotate ([0,0,90]) {
        cylinder (h=16, r=r, center=true);
    }
}

// Base
cube([BASE_LENGTH, BASE_WIDTH, THICKNESS]);    

translate([ THICKNESS, BASE_BUFFER, 0 ]){
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
                
                // Arducam mount holes
                translate([CAM_HOLE_OFFSET + CAM_DISTANCE_FROM_BASE, CAM_HOLE_OFFSET, 0]){
                    hole(CAM_HOLE_R);
                    
                    translate([CAM_HOLE_SPACING, 0, 0])
                    hole(CAM_HOLE_R);
                    
                    translate([0, CAM_HOLE_SPACING, 0])
                    hole(CAM_HOLE_R);

                    translate([CAM_HOLE_SPACING, CAM_HOLE_SPACING, 0])
                    hole(CAM_HOLE_R);
                }

                // Screw holes
                translate([CAM_DISTANCE_FROM_BASE, 0, 0]){
                    translate([CAM_SCREW_HOLES_DISTANCE, CAM_WIDTH/2, 0])
                    hole(CAM_HOLE_R);

                    translate([CAM_WIDTH-CAM_SCREW_HOLES_DISTANCE, CAM_WIDTH/2, 0])
                    hole(CAM_HOLE_R);
                }                
            }
        }
    }
    
    // Lens support
    translate([ LENS_SUPPORT_POSITION, -LENS_SUPPORT_BUFFER, 0]){
        rotate([0,-90,0]){
            difference(){
                cube([CAM_TOTAL_HEIGHT, CAM_WIDTH, LENS_SUPPORT_THICKNESS]);
                
                translate([LENS_CENTER_FROM_BASE, CAM_HEIGHT/2 + LENS_SUPPORT_BUFFER, 0]){
                    hole(LENS_R);
                    translate([-LENS_R, 0, -LENS_SUPPORT_THICKNESS/2])
                    cube([LENS_D + LENS_SUPPORT_CHOP, LENS_D, LENS_SUPPORT_THICKNESS*2]);
                }
            }
        }
        // Brace
        rotate( [0,0,-90] ){
            translate([ -THICKNESS, -BRACE_LENGTH-LENS_SUPPORT_THICKNESS,THICKNESS])
            prism( THICKNESS, BRACE_LENGTH, BRACE_HEIGHT );
        }
    }
}

SLOT_BLOCK_BUFFER = 3;
SLOT_LENGTH = BASE_LENGTH - (SLOT_BLOCK_BUFFER*2);
SLOT_HEIGHT = 4;
SLOT_BLOCK_POSITION = 0;
SLOT_BLOCK_LENGTH = SLOT_LENGTH + (SLOT_BLOCK_BUFFER*2);
SLOT_BLOCK_HEIGHT = SLOT_HEIGHT + (SLOT_BLOCK_BUFFER*2);
SLOT_ROUNDED_R = 2;

module slot() {
    translate([ SLOT_LENGTH/2+SLOT_BLOCK_BUFFER, SLOT_HEIGHT/2+SLOT_BLOCK_BUFFER, THICKNESS/2 ]) {
        difference() {
            minkowski() {
                cube([SLOT_BLOCK_LENGTH-(SLOT_ROUNDED_R*2), SLOT_BLOCK_HEIGHT-(SLOT_ROUNDED_R*2), THICKNESS/2], center=true);
                cylinder (h=THICKNESS/2, r=SLOT_ROUNDED_R, center=true);
            }
         
            hull() {
                translate([ -SLOT_LENGTH/2 + SLOT_HEIGHT/2, 0, 0 ])
                hole(SLOT_HEIGHT/2);

                translate([ SLOT_LENGTH/2 - SLOT_HEIGHT/2, 0, 0 ])
                hole(SLOT_HEIGHT/2);
            }    
        }
    }
}

translate([ SLOT_BLOCK_POSITION, BASE_WIDTH - SLOT_HEIGHT/2, 0 ])
slot();

translate([ SLOT_BLOCK_POSITION, -SLOT_BLOCK_HEIGHT + SLOT_HEIGHT/2, 0 ])
slot();

