if (state.currState == "grapplingHook") {
	var g = grapplingHook;
	draw_set_color(c_white);
	draw_line(g.startX, g.startY, g.endX, g.endY);
}

draw_set_color(c_teal);
var _x = lengthdir_x(50, aimDir);
var _y = lengthdir_y(50, aimDir);

draw_line(x, y-8, x+(_x*flip), y + _y);
	// draw_set_color(c_white);
	//draw_line(rope_start_x_ + (3*flipped_), (rope_start_y_ - 10), rope_end_x_, (rope_end_y_ -10));
	//draw_circle(rope_end_x_, (rope_end_y_ - 10), 2, false);
//} else {
	// Draw aim point at max distance/collision
		
//}

draw_self();
// get_aim();
// draw_sprite_ext(s_gun, 1, x-flipped_, y-5, .8, .8, aim_, image_blend, image_alpha);