module bolt(nut_d=10, bolt_d=5){
    cylinder(10, d=nut_d, $fn=6);
    translate([0,0,-5])cylinder(10, d=bolt_d, $fn=180);
}

module bolt_assembly(shoulder_inner=36, n=4){
    for(i=[0:1:n]){
        rotate(i*360/n, [0,0,1]) 
        translate([shoulder_inner/2, 0,0])
        rotate(30, [1,0,0])
        rotate(-90, [0,1,0]) bolt();
    }
}

module shoulder_insert(shoulder_od = 40, shoulder_id = 36, h=100){
    $fn = 180;
    difference(){
        cylinder(h=h, d = shoulder_od);
        cylinder(h=h, d = shoulder_id-5);
    }
}


module cut_shoulder_bolt( h, shoulder_id, shoulder_od, n_bolts ){

    difference(){
        shoulder_insert(h=30);
        #translate([0,0,20])bolt_assembly(n=6);
    }
}