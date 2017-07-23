PRECISION = 50;

R = 20/2;
HEIGHT = 5;

HOLE_HEIGHT = 6;
HOLE_D = 5;
HOLE_R = HOLE_D/2;

FLAT_DEPTH = 0.5;
FLAT_WIDTH = HOLE_R;
FLAT_SHIFT = -FLAT_WIDTH/2 - HOLE_R + FLAT_DEPTH;

GROOVE_WIDTH = 6.5; // nominal 3.25;
GROOVE_DEPTH_NOM = 1.75;
GROOVE_DEPTH = 3;
GROOVE_R = R - GROOVE_DEPTH_NOM;

difference() {
    union()
    {
        difference() {
            cylinder( h=HEIGHT, r1=R, r2=R, center=true, $fn=PRECISION );
            cylinder( h=HOLE_HEIGHT, r1=HOLE_R, r2=HOLE_R, center=true, $fn=PRECISION );
        }
        
        translate( [0, FLAT_SHIFT, 0] ) {
            cube([ HOLE_D, FLAT_WIDTH, HEIGHT], center=true);
        }
    }

    rotate_extrude(angle = 360, convexity = 2, $fn=PRECISION ) {
        translate([GROOVE_R,0,0]) {
            polygon( points = [ [0,0], [GROOVE_DEPTH,-GROOVE_WIDTH/2], [GROOVE_DEPTH,GROOVE_WIDTH/2] ] );
        }
    }
}


//    rotate_extrude(angle = 360, convexity = 2) {
        //translate([GROOVE_R,0,0]) {
            //polygon( points = [ [0,0], [GROOVE_DEPTH,-GROOVE_WIDTH/2], [GROOVE_DEPTH,GROOVE_WIDTH/2] ] );
        //}
    //}
//rotate_extrude(angle = 360, convexity = 2) {
//translate([5,0,0]) {
    //polygon( points = [ [0,0], [-GROOVE_WIDTH/2,GROOVE_HEIGHT], [GROOVE_WIDTH/2, GROOVE_HEIGHT] ] );
//}
//}

//rotate_extrude(convexity = 10){
//translate([2, 0, 0])
    //{circle(r = 1); }
//}

//translate([20,0,0]){
    //rotate_extrude(angle = 360, convexity = 2) {
    //translate([10,0,GROOVE_WIDTH/2]) {
        //rotate([0,90,90]){
            //polygon( points = [ [0,0], [-GROOVE_WIDTH/2,0], [GROOVE_WIDTH/2, GROOVE_HEIGHT] ] );            
        //}
    //}
    //}
//}
