difference()
{
    $fn = 48;

    // Width of nozzle holder
    w = 20;
    // Border
    b = 6;
    // Distance between nozzles
    d = 12;
    h = 17;

    // center point
    q = 12;

    // pit depth and radius
    p0 = 2;
    r0 = 6.3 / 2;
    p1 = 3;
    r1 = 9.5 / 2;

    nozzles = 7;

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
        hull()
        {
            translate([q, b + d/2 + (i - 1) * d, h - p0]) cylinder(p0, r0, r0);
            translate([w + q, b + d/2 + (i - 1) * d, h - p0]) cylinder(p0, r0, r0);
        }
        hull()
        {
            translate([q, b + d/2 + (i - 1) * d, h - p0 - p1]) cylinder(p1, r1, r1);
            translate([w + q, b + d/2 + (i - 1) * d, h - p0 - p1]) cylinder(p1, r1, r1);
        }
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
    if(b>8)
    {
        translate([w / 2, b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
        translate([w / 2, nozzles * d + 2 * b - b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
    }

    for(i = [0:10])
    {
        hull()
        {
            translate([10, j+15*i,0]) cylinder(sd1, sw1/2, sw1/2);
            translate([40, j+15*i,0]) cylinder(sd1, sw1/2, sw1/2);
        }
        hull()
        {
            translate([10, j+15*i,sd1]) cylinder(sd2, sw2/2, sw2/2, $fn=6);
            translate([40, j+15*i,sd1]) cylinder(sd2, sw2/2, sw2/2, $fn=6);
        }
        hull()
        {
            translate([-10, j+15*i,0]) cylinder(sd0, sw0/2, sw0/2);
            translate([2, j+15*i,0]) cylinder(sd0, sw0/2, sw0/2);
        }
    }
}

