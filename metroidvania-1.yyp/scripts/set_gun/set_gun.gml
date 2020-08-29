///@description Shoot the gun
///@param Ammo
///@param FireRate
function set_gun(argument0, argument1) {

	get_aim();

	var _ammo = argument0;
	var _cooldown = argument1;
	var _dir = aim_;

	if btn_X {	
		var gun_x = x - 1 * flipped_;
		var x_offset = lengthdir_x(2, _dir);
		var y_offset = lengthdir_y(2, _dir) - 5;

		if (alarm[0] <= 0) {
			var bullet = instance_create_layer(gun_x + x_offset, y + y_offset, "Player", _ammo);
			bullet.direction = _dir;
			alarm[0] = _cooldown;
		}
	}




}
