include <Dimensions.scad>

difference()
{
    $fn = 48;

    h = 17;

    // pit depth and radius
    p0 = 2;
    r0 = or;
    p1 = 3;
    r1 = tr;

    // mounting slot
    sw0 = 6.0;
    sd0 = 2.0;
    sw1 = 3.0;
    sd1 = 2.5;
    sw2 = 7.0;
    sd2 = 2.4;

    // position of first slot
    j = 10;

    union()
    {
        cube([w, nozzles * d + 2 * b, h], false);
    }
    // Slot for nozzle slit
    for(i = [1:nozzles])
    {
        // Cradle for nozzle shank
        hull()
        {
            translate([q, b + d/2 + (i - 1) * d, h - p0 - e]) cylinder(p0+2*e, r0, r0);
            translate([w + q, b + d/2 + (i - 1) * d, h - p0 - e]) cylinder(p0+2*e, r0, r0);
        }
        // Pit for tool tip
        hull()
        {
            translate([q, b + d/2 + (i - 1) * d, h - p0 - p1 - e]) cylinder(p1+2*e, r1, r1);
            translate([w + q, b + d/2 + (i - 1) * d, h - p0 - p1 - e]) cylinder(p1+2*e, r1, r1);
        }
        // Launch pad
        translate([w, b + d/2 + (i - 1) * d, h - p0]) cylinder(p1, r1, r1);
    }
    // Screw holes for holding all layers together
    for(i = [-1:nozzles + 1])
    {
        translate([w - 16, b + d + (i - 1) * d, h-10]) cylinder(h, 1.6, 1.6);
        hull()
        {
            translate([w - 16, b + d + (i - 1) * d, h - 6]) cylinder(2.5, 3.3, 3.3, $fn = 6);
            translate([-5, b + d + (i - 1) * d, h - 6]) cylinder(2.5, 3.3, 3.3, $fn = 6);
        }
    }

    // If we have wide border, then add a through hole. Default parameters above do not
    if(b>8)
    {
        translate([w / 2, b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
        translate([w / 2, nozzles * d + 2 * b - b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
    }

    // An array of slots for mounting on the table. 15mm pitch
    for(i = [0:round((b*2+d*nozzles-j*2)/15)])
    {
        // Clearance for the screw thread
        hull()
        {
            translate([10, j+15*i,-e]) cylinder(sd1+2*e, sw1/2, sw1/2);
            translate([40, j+15*i,-e]) cylinder(sd1+2*e, sw1/2, sw1/2);
        }
        // Clearance for the bolt head
        hull()
        {
            translate([10, j+15*i,sd1]) cylinder(sd2, sw2/2, sw2/2, $fn=6);
            translate([40, j+15*i,sd1]) cylinder(sd2, sw2/2, sw2/2, $fn=6);
        }
        // Cutout for any bolts holding other items on the table
        hull()
        {
            translate([-10, j+15*i,-e]) cylinder(sd0+e, sw0/2, sw0/2);
            translate([2, j+15*i,-e]) cylinder(sd0+e, sw0/2, sw0/2);
        }
    }
}

