DEFAULT_THICKNESS = 3;

BASE_PLATE_WIDTH = 32;
BASE_PLATE_DEPTH = 16.5;
BASE_PLATE_HOLE_SPACING = 20.5;
BASE_PLATE_HOLE_OFFSET = (BASE_PLATE_WIDTH-BASE_PLATE_HOLE_SPACING) / 2;
BASE_HOLE_RADIUS = 1.5;
BASE_BRACE_WIDTH = BASE_PLATE_DEPTH - DEFAULT_THICKNESS;

VERTICAL_HEIGHT = 32;
BLOCK_HEIGHT = 5;
BLOCK_DEPTH = 15;

CAM_PLATE_SHIFT = 6;
CAM_PLATE_WIDTH = 36;
CAM_PLATE_PADDING = 2;
CAM_PLATE_HEIGHT = CAM_PLATE_WIDTH + CAM_PLATE_PADDING;
CAM_PLATE_HOLE_SPACING = 29;
CAM_PLATE_HOLE_OFFSET = (CAM_PLATE_WIDTH-CAM_PLATE_HOLE_SPACING) / 2;
CAM_HOLE_RADIUS = 1.5;

CAM_PLATE_OVERHANG = ( CAM_PLATE_WIDTH - BASE_PLATE_WIDTH ) / 2;

CAM_BRACE_WIDTH = 12;
CAM_BRACE_DEPTH = 6;

echo("BASE_PLATE_HOLE_OFFSET = ", BASE_PLATE_HOLE_OFFSET );

module prism(l, w, h){
   polyhedron(
       points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
       faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );   
}


module base_hole(){
    rotate ([0,0,90]) {
        cylinder (h = 10, r=BASE_HOLE_RADIUS, center = true, $fn=100);
    }
}

module cam_hole(){
    rotate ([90,0,0]) {
        cylinder (h = 10, r=CAM_HOLE_RADIUS, center = true, $fn=100);
    }
}
        
difference() {
	cube([BASE_PLATE_WIDTH, BASE_PLATE_DEPTH, DEFAULT_THICKNESS]);
    translate([BASE_PLATE_HOLE_OFFSET,BASE_PLATE_DEPTH/2,1]){
        base_hole();
    }
    translate([BASE_PLATE_HOLE_OFFSET+BASE_PLATE_HOLE_SPACING,BASE_PLATE_DEPTH/2,1]){
        base_hole();
    }
}

translate([0,0,DEFAULT_THICKNESS]){
    prism(DEFAULT_THICKNESS, BASE_BRACE_WIDTH, BASE_BRACE_WIDTH);
}
translate([(BASE_PLATE_WIDTH/2)-DEFAULT_THICKNESS,0,DEFAULT_THICKNESS]){
    prism(DEFAULT_THICKNESS*2, BASE_BRACE_WIDTH, BASE_BRACE_WIDTH);
}
translate([BASE_PLATE_WIDTH - DEFAULT_THICKNESS,0,DEFAULT_THICKNESS]){
    prism(DEFAULT_THICKNESS, BASE_BRACE_WIDTH, BASE_BRACE_WIDTH);
}
        
translate([0, BASE_BRACE_WIDTH, DEFAULT_THICKNESS]){
    cube([BASE_PLATE_WIDTH,DEFAULT_THICKNESS,VERTICAL_HEIGHT]);

    translate([-CAM_PLATE_OVERHANG,0,VERTICAL_HEIGHT-DEFAULT_THICKNESS]){
        cube([CAM_PLATE_WIDTH, BLOCK_DEPTH, BLOCK_HEIGHT]);        
    }
    
    translate([-CAM_PLATE_OVERHANG, CAM_PLATE_SHIFT, VERTICAL_HEIGHT+2]){
        difference() {
            cube([CAM_PLATE_WIDTH, DEFAULT_THICKNESS, CAM_PLATE_HEIGHT]);
            translate([CAM_PLATE_HOLE_OFFSET,0,CAM_PLATE_HOLE_OFFSET+CAM_PLATE_PADDING]){
                cam_hole();
                translate([CAM_PLATE_HOLE_SPACING,0,0]){
                cam_hole();
                }
                translate([CAM_PLATE_HOLE_SPACING,0,CAM_PLATE_HOLE_SPACING]){
                cam_hole();
                }
                translate([0,0,CAM_PLATE_HOLE_SPACING]){
                cam_hole();
                }
            }
        }
    
        translate([(CAM_PLATE_WIDTH/2)+(CAM_BRACE_WIDTH/2), CAM_BRACE_DEPTH + DEFAULT_THICKNESS, 0]){
            rotate([0,0,180]) {
            prism(CAM_BRACE_WIDTH, CAM_BRACE_DEPTH, CAM_BRACE_DEPTH);
            }
        }
    }
}
