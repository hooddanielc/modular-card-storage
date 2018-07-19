// Y is the sky
// X is the width
// Z is the length
// Handle faces positive z axis
drawer_size_x = 346.075; // width
drawer_size_z = 377.825; // length
drawer_size_y = 98.425;  // height
drawer_thickness = 19.05;

// outer edge
drawer_outer_x = drawer_size_x + (drawer_thickness * 2);
drawer_outer_y = drawer_size_y + drawer_thickness - 0.1;
drawer_outer_z = drawer_size_z + (drawer_thickness * 2);

// the drawer container
difference() {
  translate([-drawer_thickness, -drawer_thickness, -drawer_thickness]) {
    cube([drawer_outer_x, drawer_outer_y, drawer_outer_z]);
  }
  cube([drawer_size_x, drawer_size_y, drawer_size_z]);
}

// card container is exactly half the length of 
// the dresser drawer
card_container_thickness = 5;
card_container_x = 66.675;
card_container_y = 92.075;
card_container_z = (drawer_size_z / 2) - card_container_thickness;

card_outer_x = card_container_x + (card_container_thickness * 2);
card_outer_y = card_container_y + card_container_thickness;
card_outer_z = card_container_z + card_container_thickness;

slit_part_offset = 2.5;
slit_part_x = card_outer_x - (slit_part_offset * 2);
slit_part_z = 5;
slit_part_y = slit_part_offset + card_container_y;

module slit() {
  translate([card_container_thickness - slit_part_offset, slit_part_offset, card_container_thickness]) {
    difference() {
      cube([slit_part_x, slit_part_y, slit_part_z]);
      union() {
        cube([card_container_thickness * 2, slit_part_y / 2, slit_part_z]);
        translate([slit_part_x - (card_container_thickness * 2), 0, 0])
        cube([card_container_thickness * 2, slit_part_y / 2, slit_part_z]);
      }
    }
  }
}

module row_of_slits() {
  union() {
    slit();
    translate([0, 0, 20]) slit();
    translate([0, 0, 40]) slit();
    translate([0, 0, 60]) slit();
    translate([0, 0, 80]) slit();
    translate([0, 0, 100]) slit();
    translate([0, 0, 120]) slit();
    translate([0, 0, 140]) slit();
    translate([0, 0, 160]) slit();
  }
}

module container() {
  difference() {
    cube([card_outer_x, card_outer_y, card_outer_z]);

    union() {
      translate([card_container_thickness, card_container_thickness, card_container_thickness]) {
        cube([card_container_x, card_container_y + 0.1, card_container_z + 0.1]);
      }
    }

    row_of_slits();

  }
}

container();

translate([card_outer_x, 0, 0])
container();

translate([card_outer_x * 2, 0, 0])
container();

translate([card_outer_x * 3, 0, 0])
container();

translate([0, 0, 10]) {
  row_of_slits();
}