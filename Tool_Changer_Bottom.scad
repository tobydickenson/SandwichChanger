include <Dimensions.scad>

intersection()
{
    $fn = 48;

    // Nozzle slot thickness
    s = 1.1;

    // center point
    q = 12;

    h = s+gap;

    difference()
    {
        union()
        {
            linear_extrude(h) offset(1) offset(-1) square([w, nozzles * d + 2 * b]);
        }
        // Slot for nozzle slit
        for(i = [1:nozzles])
        {
            hull()
            {
                translate([q, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2*e, r, r);
                translate([w + q, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2*e, r, r);
            }
            translate([w, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2*e, tr, tr);
            
            // lead in
            hull()
            {
                translate([w-tr+r, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2*e, r+0.5, r+0.5);
                translate([q+r, b + d/2 + (i - 1) * d, -e]) cylinder(h + 2*e, r, r);
            }
            
            // slice down to the right thickness for the nozzle slot
            translate([q-or-0.2, b + d/2 + (i - 1) * d - d/2, s]) cube([20, d+e, 10], false);
        }

        // Screw holes for holding all layers together
        for(i = [-1:nozzles + 1])
        {
            translate([w - 16, b + d + (i - 1) * d, -e]) cylinder(h + 2*e, 1.6, 1.6);
        }

        // If we have wide border, then add a through hole. Default parameters above do not
        if(b>8)
        {
            translate([w / 2, b / 2, -e]) cylinder(h + 2*e, 2.2, 2.2);
            translate([w / 2, nozzles * d + 2 * b - b / 2, -e]) cylinder(h + 2*e, 2.2, 2.2);
        }
    }
}
