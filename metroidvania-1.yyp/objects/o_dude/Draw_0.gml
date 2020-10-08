var g = grapplingHook;

// var _x = lengthdir_x(g.chainMaxLength * flip, aimDir);
// var _y = lengthdir_y(g.chainMaxLength, aimDir);


if (state.currState == "grapplingHook") {
	
	
	draw_set_color(c_white);
	draw_line(g.startX, g.startY, g.endX, g.endY);
} else {
	draw_set_color(c_teal);
	draw_circle(g.endX, g.endY, 3, true);
}




// draw_line(x, y-8, x+_x, y-8 + _y);
	// draw_set_color(c_white);
	//draw_line(rope_start_x_ + (3*flipped_), (rope_start_y_ - 10), rope_end_x_, (rope_end_y_ -10));
	//draw_circle(rope_end_x_, (rope_end_y_ - 10), 2, false);
//} else {
	// Draw aim point at max distance/collision
		
//}

draw_self();
