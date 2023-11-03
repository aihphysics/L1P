module bolt(nut_d=10, bolt_d=5){
    cylinder(10, d=nut_d, $fn=6);
    translate([0,0,-10])cylinder(20, d=bolt_d, $fn=180);
}

module bolt_assembly(shoulder_inner=36, n=4){
    for(i=[0:1:n]){
        rotate(i*360/n, [0,0,1]) 
        translate([shoulder_inner/2, 0,0])
        rotate(30, [1,0,0])
        rotate(-90, [0,1,0]) bolt();
    }
}

module chamfer_insert( shoulder_od, shoulder_id, shoulder_height ){
    chamfer_width=shoulder_od-shoulder_id+1.5;
    translate( [0, 0, shoulder_height] )
    rotate_extrude($fn=200) 
    translate( [shoulder_id/2.0-2.5, 0, 0 ] )
    polygon( points=[[ 0, 0 ], [ chamfer_width, 0 ], [ chamfer_width, 10]] );
}


module shoulder_insert(shoulder_od = 40, shoulder_id = 36, h=100){
    $fn = 180;
    difference(){
        cylinder(h=h, d = shoulder_od);
        // cure the z-fight on fast render with a lengthen+translate
        translate([0,0,-2.5])cylinder(h=h+5, d = shoulder_id-5);
    }
}


module shoulder_nuts( h_shoulder, h_cut, shoulder_id, shoulder_od, n_bolts){
    
        difference(){
            shoulder_insert(shoulder_od, shoulder_id, h=h_shoulder);
            translate([0,0,h_cut])bolt_assembly( shoulder_id, n_bolts );
        }
        
        chamfer_insert( shoulder_od, shoulder_id, h_shoulder);
//    
}
module shoulder_bolts( h_shoulder, h_cut, shoulder_id, shoulder_od, n_bolts){
    translate([0,0,h_cut])bolt_assembly( shoulder_id,n_bolts );
}