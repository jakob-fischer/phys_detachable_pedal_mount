frame_diameter = 38.5;
screw_diameter = 5;
screw_head_diameter = 8.5;
screw_head_depth = 3;
screw_nut_size = 8.2;
screw_nut_depth = 3;
cut_size = 2.0;


height = 30;
thickness = 3;
frame_pedal_mount_dist = 14;
pedal_mount_diam_1 = 11.5;
pedal_mount_depth_1 = 15.0;
pedal_mount_diam_2 = 9.0;


module pedal_mount() {
    difference() {
        union() {
            cylinder(h=height, r=pedal_mount_diam_1/2+thickness);
            translate([-(pedal_mount_diam_1/2+thickness),0,0])
            cube([pedal_mount_diam_1+thickness*2,frame_diameter/2+frame_pedal_mount_dist,height]);
        }

        translate([0,0,-0.5])
        cylinder(h=height+1, r=pedal_mount_diam_2/2);
        
        translate([0,0,height-pedal_mount_depth_1])
        cylinder(h=height+1, r=pedal_mount_diam_1/2);
    }
}









difference() {
   union() {
       cylinder(h=height, r=(frame_diameter/2)+thickness); 
       translate([0,-(frame_pedal_mount_dist+frame_diameter/2),0])
           pedal_mount();
   }   
   translate([0,0,-0.5]) {
       cylinder(h=height+1, r=frame_diameter/2);
       translate([-frame_diameter,-cut_size/2, -height]) 
           cube([2*frame_diameter, cut_size,3*height]);
   }
 }

