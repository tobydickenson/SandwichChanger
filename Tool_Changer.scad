// Total view of the three layers
// Not for printing but for visiaulisation

offset = 10.0;

translate([0, 0, 3.4+2*offset]) color([0.8, 0.5, 1])  { include <Tool_Changer_Top.scad> }

translate([0, 0, 1.4+1*offset]) color([0, 1, 0.2]) { include <Tool_Changer_Middle.scad> }

translate([0, 0, 0]) color([0, 0.5, 1])  { include <Tool_Changer_Bottom.scad> }

translate([0, 0, -14-1*offset]) color([1, 0.8, 0]) { include <Tool_Changer_Mount.scad> }
