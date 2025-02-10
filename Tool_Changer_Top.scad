include <Dimensions.scad>

intersection()
{
    $fn = 48;

    h = 3;

    difference()
    {
        union()
        {
            linear_extrude(h) offset(1) offset(-1) square([w, nozzles * d + 2 * b]);
        }
        // Slot for nozzle slit
        for(i = [1:nozzles])
        {
            // Cradle for the nozzle tip shank
            hull()
            {
                translate([q, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2 + 2*e, or, or);
                translate([w + q, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2 + 2*e, or, or);
            }
            // The launch pad
            hull()
            {
                translate([w, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2 + 2*e, tr, tr);
                translate([w + q, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2 + 2*e, tr, tr);
            }
        }
        // Screw holes for holding all layers together
        for(i = [-1:nozzles + 1])
        {
            translate([w - 16, b + d + (i - 1) * d, -1]) cylinder(h + 2, 1.6, 1.6);
        }

        // If we have wide border, then add a through hole. Default parameters above do not
        if(b>8)
        {
            translate([w / 2, b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
            translate([w / 2, nozzles * d + 2 * b - b / 2, -1]) cylinder(h + 2, 2.2, 2.2);
        }
    }
}
