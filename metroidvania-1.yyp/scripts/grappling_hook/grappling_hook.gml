function init_grappling_hook(argument0, argument1, argument2, argument3, argument4) {

	grapple_owned_ = argument0;
	rope_start_x_ = x + argument1 * flipped_;
	rope_start_y_ = argument2 - 8;
	rope_length_ = argument3;
	rope_max_length_ = argument4;

	rope_end_x_ = rope_start_x_;
	rope_end_y_ = rope_start_y_;

	rope_angle_ = 0;
	rope_angle_velocity_ = 0;
}

function set_grappling_hook() {
	if (!o_dude.grapple_owned_) { return false; }

	var _end_x = 3;
	var _end_y = 8;

	rope_length_ = 0;
	rope_end_x_ = rope_start_x_ - (_end_x * flipped_);
	rope_end_y_ = rope_start_y_ + _end_y;

	while !place_meeting(rope_end_x_, rope_end_y_, o_solid) && (rope_length_ < rope_max_length_) {
		_end_x += 2.5;
		_end_y++;
		rope_end_x_ = rope_start_x_ + (_end_x * flipped_);
		rope_end_y_ = rope_start_y_ - _end_y;
		rope_length_ = point_distance(rope_end_x_, rope_end_y_, rope_start_x_, rope_start_y_);
	}

	if place_meeting(rope_end_x_, rope_end_y_, o_solid) && rope_length_ < rope_max_length_ {
		rope_angle_velocity_ = 0;
		state_ = player.grapple;
	} else {
		draw_set_color(c_red);
		draw_circle(rope_end_x_, (rope_end_y_ - 10), 2, false);
	}






}
