include <Dimensions.scad>

intersection()
{
    $fn = 48;

    h = 2;

    // gripper grip distance
    o = 0.6;
    // slot width to accomodate gripper movement
    m = o*2;
    // gripper width
    t = 1.2;
    // narrow opening slot
    g = 0.5;

    difference()
    {
        union()
        {
            linear_extrude(h) offset(1) offset(-1) square([w, nozzles * d + 2 * b]);
        }
        // Slot for nozzle slit
        for(i = [1:nozzles])
        {
            // Nozzle shank
            translate([q, b + d/2 + (i - 1) * d, -e]) cylinder(h +2*e, or, or);
            // Lead-in
            translate([q+3.2+o*2, b + d/2 + (i - 1) * d, -e]) cylinder(h +2*e, or, or);
            // Shape the tip of the gripper arms
            hull()
            {
                translate([q, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2*e, or - o, or - o);
                translate([w + q, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2*e, or - o, or - o);
            }
            // Cut out for spring
            translate([q+4, b + (i - 1) * d, -e]) cube([20, d, h+2*e], false);     // remove ends
            translate([q-2, b + d/2 + (i - 1) * d - d/2, h-gap]) cube([10, d, h], false); // front overcut

            translate([q-5, b + d/2 + (i - 1) * d - or , -e]) cube([5, g, h+2*e], false);       // slot l
            translate([q-5, b + d/2 + (i - 1) * d + or - g , -e]) cube([5, g, h+2*e], false);   // slot r
            translate([q-5, b + (i - 1) * d  , h-gap]) cube([10, d/2-or, h], false); // overcut on arm
            translate([q-5, b + (i - 1) * d + d/2 + or , h-gap]) cube([10, d/2-or, h], false); // overcut on arm

        }
        if(1)
        {
            // Slot for nozzle slit
            for(i = [-1:nozzles+1])
            {
                hull()
                {
                    r = d/2-or-t;
                    translate([q-5+r, b + (i - 1) * d , -e]) cylinder(h+2*e, r,r, $fn=12);
                    translate([q+3-r, b + (i - 1) * d , -e]) cylinder(h+2*e, r,r, $fn=12);
                }
            }
            for(i = [0:nozzles])
            {
                // slot between adjacent gripper arms
                translate([q-4, b + i * d -m/2, -e]) cube([20, m, h+2*e], false);
            }
        }
        // Screw holes for holding all layers together
        for(i = [-1:nozzles + 1])
        {
            translate([w - 16, b + d + (i - 1) * d, -e]) cylinder(h + 2*e, 1.6, 1.6);
        }

        // If we have wide border, then add a through hole. Default parameters above do not
        if(b>8)
        {
            translate([w / 2, b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
            translate([w / 2, nozzles * d + 2 * b - b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
        }

        if(cutaway_visualisation)
        {
            translate([0,0,-1]) linear_extrude(h+2) offset(e) square([w, 2*d + b]);
        }
    }
}
