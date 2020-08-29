gamepad();

dir = move_right - move_left;
flip = dir != 0 ? dir : flip;
aimDir = point_direction(0, 0, dir, (move_down - move_up));
image_xscale = flip;

state.step();
