function init_gun() {
	equipped_ammo_ = o_bullet_basic;
	bullet_cooldown_ = room_speed * 0.2;

	aim_ = 0;

	base_aim_x = x + (10*flipped_);
	base_aim_y = y-10;
	aim_x = base_aim_x + flipped_;
	aim_y = base_aim_y - 1;
	max_aim_distance = 100;
	aim_distance = 0;
}
