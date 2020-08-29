if not instance_exists(target_) exit;
x = lerp(x, target_.x, 0.05);
y = lerp(y, target_.y-8, 0.05);
x = roundTo(x, 1/scale_);
y = roundTo(y, 1/scale_);
x = clamp(x, camera_max_left_, camera_max_right_);
y = clamp(y, camera_max_top_, camera_max_bottom_);
camera_set_view_pos(view_camera[0], x-width_/2, y-height_/2);
