check_input();

// find direction of movement
var _wasd_direction = point_direction(0,0,input.hdir,input.vdir);
dir = _wasd_direction - o_camera.rotation + angle;
vel = walk_speed*(abs(input.hdir) or abs(input.vdir));

// calculate facing for sprite drawing
if input.hdir != 0 or input.vdir != 0 {
	facing = floor(_wasd_direction / 90);
}

// void water
if place_meeting(x,y,o_void_water) {
	vel	/= 3;
}


// move in the x-direction
hsp = lengthdir_x(vel, dir);
hsp_remaining = abs(hsp);
var _xleftover = hsp mod 1;
repeat(hsp_remaining) {
	hsp_remaining = approach(hsp_remaining, 0, 1);
	if place_meeting(x+sign(hsp),y,o_wall) {
		hsp_remaining = 0;
		break;
	}
	x += sign(hsp);
	hsp_remaining -= 1;
}
if !place_meeting(x+sign(hsp),y,o_wall) {
	x += _xleftover;
}
			
// move in the y-direction
vsp = lengthdir_y(vel, dir);
vsp_remaining = abs(vsp);
var _yleftover = vsp mod 1;
repeat(vsp_remaining) {
	vsp_remaining = approach(vsp_remaining, 0, 1);
	if place_meeting(x,y+sign(vsp),o_wall) {
		vsp_remaining = 0;
		break;
	}
	vsp_remaining -= 1;
	y += sign(vsp);
}
if !place_meeting(x,y+sign(vsp)*vsp_remaining,o_wall) {
	y += _yleftover;
}

