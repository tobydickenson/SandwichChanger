intersection()
{
    $fn = 48;

    // Radius of nozzle tip where to hold
    r = 3.6 / 2;
    or = 6.6 / 2;
    tr = 9.5 / 2;

    // center point
    q = 12;

    // Width of nozzle holder
    w = 20;
    // Border
    b = 6;
    // Distance between nozzles
    d = 12;
    h = 2;

    // gripper grip distance
    o = 0.6;
    // slot width to accomodate gripper movement
    m = o*2;
    // gripper width
    t = 1.2;
    nozzles = 7;
    // narrow opening slot
    g = 0.5;

    difference()
    {
        union()
        {
            cube([w, nozzles * d + 2 * b, h], false);
        }
        // Slot for nozzle slit
        for(i = [1:nozzles])
        {
            translate([q, b + d/2 + (i - 1) * d, 0]) cylinder(h + 2, or, or);
            translate([q+3.2+o*2, b + d/2 + (i - 1) * d, 0]) cylinder(h + 2, or, or);
            hull()
            {
                translate([q, b + d/2 + (i - 1) * d, 0]) cylinder(h + 2, or - o, or - o);
                translate([w + q, b + d/2 + (i - 1) * d, 0]) cylinder(h + 2, or - o, or - o);
            }
            hull()
            {
                translate([w, b + d/2 + (i - 1) * d, 0]) cylinder(h + 2, tr, tr);
                translate([w + q, b + d/2 + (i - 1) * d, 0]) cylinder(h + 2, tr, tr);
            }
            hull()
            {
                translate([w - 3, b + d/2 + (i - 1) * d, -1]) cylinder(h + 2, or, or);
                translate([w + q, b + d/2 + (i - 1) * d, -1]) cylinder(h + 2, or, or);
            }
            // Cut out for spring
            translate([q+4, b + (i - 1) * d, 0]) cube([20, d, 3], false);     // remove ends
            translate([q-2, b + d/2 + (i - 1) * d - d/2, 1.6]) cube([10, d, 3], false); // overcut

            translate([q-5, b + d/2 + (i - 1) * d - or , 0]) cube([5, g, 3], false); // slot
            translate([q-5, b + d/2 + (i - 1) * d + or - g , 0]) cube([5, g, 3], false);           // slot
            translate([q-5, b + (i - 1) * d  , 1.6]) cube([10, d/2-or, 3], false); // overcut on arm
            translate([q-5, b + (i - 1) * d + d/2 + or , 1.6]) cube([10, d/2-or, 3], false); // overcut on arm

        }
        if(1)
        {
            // Slot for nozzle slit
            for(i = [-1:nozzles+1])
            {
                hull()
                {
                    r = d/2-or-t;
                    translate([q-5+r, b + (i - 1) * d , 0]) cylinder(h+2, r,r, $fn=12);
                    translate([q+3-r, b + (i - 1) * d , 0]) cylinder(h+2, r,r, $fn=12);
                }
            }
            for(i = [0:nozzles])
            {
                translate([q-4, b + i * d -m/2, 0]) cube([20, m, 3], false);           // slot
            }
        }
        // Screw holes for holding all layers together
        for(i = [-1:nozzles + 1])
        {
            translate([w - 16, b + d + (i - 1) * d, -1]) cylinder(h + 2, 1.6, 1.6);
        }
        // Holes for M4 mounting screws at both sides
        if(b>8)
        {
            translate([w / 2, b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
            translate([w / 2, nozzles * d + 2 * b - b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
        }
    }
}
