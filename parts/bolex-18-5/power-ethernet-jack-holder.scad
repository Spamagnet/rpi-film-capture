$fn=50;
openingWidth = 17.2;
openingHeight = 24.2;
cornerRadius = 3.0;
openingDepth = 4.0;
separation = 8.8;

baseBufferVert = 9.0;
baseBufferHorz = 3.0;
baseDepth = 2.0;
baseWidth = baseBufferHorz + openingWidth + baseBufferHorz;
baseHeight = baseBufferVert + openingHeight + separation + openingHeight + baseBufferVert;

// Screw holes
screwHoleDiameter = 3.2;
screwHoleRadius = screwHoleDiameter/2;
screwHoleX = baseWidth/2;
screwHoleOneY = baseBufferVert/2;
screwHoleTwoY = baseHeight - baseBufferVert/2;

// Openings that the plugs go through
firstOpeningY = baseBufferVert;
secondOpeningY = baseBufferVert + openingHeight + separation;

// Hole one - Ethernet
holeOneWidth = 15.8;
holeOneHeight = 20.0;
holeOneX = baseBufferHorz + ( openingWidth - holeOneWidth ) /2;
holeOneY = baseBufferVert + ( openingHeight - holeOneHeight ) / 2;

holeOneX = baseBufferHorz + ( openingWidth - holeOneWidth ) /2;
holeOneY = baseBufferVert + ( openingHeight - holeOneHeight ) / 2;

// Hole two - Power
holeTwoWidth = 15.8;
holeTwoHeight = 20.0;
holeTwoX = baseBufferHorz + ( openingWidth - holeTwoWidth ) /2;
holeTwoY = secondOpeningY + ( openingHeight - holeTwoHeight ) / 2;

powerBoxWidth = 16.4;
powerBoxHeight = openingHeight - 2.0;
powerPortDiameter = 12.6 + 0.8;
powerPortRadius = powerPortDiameter / 2;
powerPortDepth = 4.0;
powerPortInset = 2.0;
powerPortInsetBorder = 1.0;

powerBoxX = baseBufferHorz + ( openingWidth - powerBoxWidth ) /2;
powerBoxY = secondOpeningY + ( openingHeight - powerBoxHeight ) / 2;

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
        translate([0, 0, openingDepth])
        cube( [baseWidth, baseHeight, baseDepth] );

        translate( [ baseBufferHorz, firstOpeningY, 0] ) {
            plug( openingWidth, openingHeight, openingDepth, cornerRadius );
        }

        translate( [ baseBufferHorz, secondOpeningY, 0] ) {
            plug( openingWidth, openingHeight, openingDepth, cornerRadius );
        }
    }
    
    // Screw holes
    translate( [screwHoleX, screwHoleOneY, -1] )
    cylinder( h=20, r=screwHoleRadius, center=true );

    translate( [screwHoleX, screwHoleTwoY, -1] )
    cylinder( h=20, r=screwHoleRadius, center=true );
    
    // Hole one
    translate( [holeOneX, holeOneY, -10 ] )
    cube( [holeOneWidth, holeOneHeight, 50] );

    // Hole two
    translate( [powerBoxX, powerBoxY, 0 ] ) {
        union() {
            translate([ powerBoxWidth/2, powerBoxHeight/2, 0]) {
                translate( [0, 0, 0 ])
                cylinder( h=powerPortInset, r=powerPortRadius+powerPortInsetBorder, center=true );
                
                translate( [0, 0, powerPortInset ])
                cylinder( h=powerPortDepth+5, r=powerPortRadius, center=true );
            }
        }
    }

}
