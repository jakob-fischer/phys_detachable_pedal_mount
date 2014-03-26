// author: Jakob Fischer (jakob@automorph.info)
// date: 3/26/2014
// description: 3d-model for an attachement of a "MKS Lambda Ezy Superior"
// pedal on a brompton bicycle. Might work for other pedals and bicycles 
// if you change the values. 
//
// Possible improvements are allowing a tilted angel of pedal mount. This 
// might reduce the risk of scratches on the frame. Distance of mount from
// frame can also be adjusted by 'frame_pedal_mount_dist'.

// Precission of round parts (cylinders)
$fn = 50;

frame_diameter = 38.5;
screw_diameter = 5;
cut_size = 1.0;          // structure is cut from a cylinder - this value regulates the size of the cut 
                         // between the two parts  => influences the possible tension through the screws 
height = 30;
thickness = 2;

frame_pedal_mount_dist = 14;
pedal_mount_diam_1 = 11.5;        // diameter of upper part
pedal_mount_depth_1 = 15.0;       // depth of upper part
pedal_mount_diam_2 = 9.3;         // diameter of lower part - 9.0 was to tight when printing with PLA

flap_length = 13;                  // regulates size of flaps for screws
flap_radius = 14;


// 
// Code for the pedal mount part
//

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



//
// Main code - connection to the frame
//

flap_trans = frame_diameter/2+thickness+flap_length-flap_radius;

difference() {
   union() {
       cylinder(h=height, r=(frame_diameter/2)+thickness); 
       translate([0,-(frame_pedal_mount_dist+frame_diameter/2),0])
           pedal_mount();

       
       translate([flap_trans,0, height/2])
          rotate(90, [1,0,0])
          cylinder(h=cut_size+2*thickness, r=flap_radius, center=true);

       translate([-flap_trans,0, height/2])
          rotate(90, [1,0,0])
          cylinder(h=cut_size+2*thickness, r=flap_radius, center=true);
   }   
   translate([0,0,-0.5]) {
       cylinder(h=height+1, r=frame_diameter/2);
       translate([-frame_diameter,-cut_size/2, -height]) 
           cube([2*frame_diameter, cut_size,3*height]);
   }

   translate([frame_diameter/2+thickness+flap_length/2,0,height/2])
       rotate(90, [1,0,0])
           cylinder(h=pedal_mount_diam_1+thickness*2, r=screw_diameter/2, center=true);

   translate([-(frame_diameter/2+thickness+flap_length/2),0,height/2])
       rotate(90, [1,0,0])
           cylinder(h=pedal_mount_diam_1+thickness*2, r=screw_diameter/2, center=true);
 }

