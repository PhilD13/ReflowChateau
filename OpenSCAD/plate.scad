
$fn = 20;

width = 60.4;
length = 162.2;

screenWidth = 50.9;
screenLength = 70.6;

screwD = 2.9;

frameStandoffHorzSep = 48.6;
frameStandoffVert = [-68.5, -15.2, 75];

pcbStandoff = [[12.7, 0],
			  [-12.7, 0],
               [12.7, 80], 
			  [-12.7, 80]];

pcbStandoffY = -12;


difference(){
	translate([0, 0, 1.5])
	hull(){
		roundedCube([width, length, 3], 4);
		translate([0, 0, 0.5])
		roundedCube([width-4, length-4, 4], 2);
	}
	
	translate([0, 28.5, 2.5])
	cube([screenWidth, screenLength, 5], center = true);

	for (i = frameStandoffVert){
		for (j = [-1, 1]){
			translate([j*frameStandoffHorzSep/2, i, 0])
			cylinder(r = screwD/2, h = 3);
		}
	}
}


for (i = frameStandoffVert){
	for (j = [-1, 1]){
		translate([j*frameStandoffHorzSep/2, i, 0])
		standoff(6, 5);
	}
}

translate([0, pcbStandoffY, 0])
for (i = pcbStandoff){
	translate(i)
	standoff(6, 14.6);
}


module standoff(diameter, height){
	translate([0, 0, -height])
	difference(){	
		cylinder(r = diameter/2, h = height);
		cylinder(r = screwD/2, h = height);
	}
}



module roundedCube(size, radius) {
  cube(size - [2*radius,0,0], true);
  cube(size - [0,2*radius,0], true);
  for (x = [radius-size[0]/2, -radius+size[0]/2],
       y = [radius-size[1]/2, -radius+size[1]/2]) {
    translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
  }
}