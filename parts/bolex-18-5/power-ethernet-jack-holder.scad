$fn=50;
openingWidth = 17.8;
openingHeight = 25.4;
cornerRadius = 2.0;
openingDepth = 4.0;
separation = 7.6;

baseBuffer = 3.0;
baseDepth = 2.0;
baseWidth = baseBuffer + openingWidth + baseBuffer;
baseHeight = baseBuffer + openingHeight + separation + openingHeight + baseBuffer;

firstOpeningY = baseBuffer;
secondOpeningY = baseBuffer + openingHeight + separation;

holeOneWidth = 15.8;
holeOneHeight = 15.0;
holeOneX = baseBuffer + ( openingWidth - holeOneWidth ) /2;
holeOneY = baseBuffer + ( openingHeight - holeOneHeight ) / 2;

holeTwoWidth = 15.8;
holeTwoHeight = 15.0;
holeTwoX = baseBuffer + ( openingWidth - holeOneWidth ) /2;
holeTwoY = secondOpeningY + ( openingHeight - holeOneHeight ) / 2;

//hull() {
//    translate([15,10,0]) circle(10);
//    circle(10);
//}

module plug(w, h, d, cr){
    linear_extrude(d)
    hull() {
        translate([cr, cr, 0])
        circle(cr);

        translate([w-cr, h-cr, 0])
        circle(cr);
        
        translate([w-cr, cr, 0])
        circle(cr);
        
        translate([cr,  h-cr, 0])
        circle(cr);
    }
}

difference() {
    union() {
        translate([0,0,openingDepth])
        cube( [baseWidth, baseHeight, baseDepth] );

        translate( [ baseBuffer, firstOpeningY, 0] ) {
            plug( openingWidth, openingHeight, openingDepth, cornerRadius );
        }

        translate( [ baseBuffer, secondOpeningY, 0] ) {
            plug( openingWidth, openingHeight, openingDepth, cornerRadius );
        }
    }

    translate( [holeOneX, holeOneY, -10 ] )
    cube( [holeOneWidth, holeOneHeight, 50] );

    translate( [holeTwoX, holeTwoY, -10 ] )
    cube( [holeTwoWidth, holeTwoHeight, 50] );
}
