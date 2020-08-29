///@description Player State
///@param state_
function player_state(argument0) {

	var _state = argument0;

	sprite_array_[player.idle] = s_dude_idle;
	sprite_array_[player.run] = s_dude_run;
	sprite_array_[player.jump] = s_dude_jump;
	sprite_array_[player.fall] = s_dude_fall;
	sprite_array_[player.attack] = s_dude_attack;
	sprite_array_[player.slash] = s_dude_slash;
	sprite_array_[player.uppercut] = s_dude_uppercut;
	sprite_array_[player.slam] = s_dude_slam;
	sprite_array_[player.wall_grab] = s_dude_wall_grab;
	sprite_array_[player.wall_launch] = s_dude_wall_launch;
	sprite_array_[player.grapple] = s_dude_grapple;
	sprite_array_[player.dodge] = s_dude_dodge;
	sprite_array_[player.double_jump] = s_dude_tucked;
	/* 
	sprite_array_[player.shoot] = s_dude_shoot;
	sprite_array_[player.dash] = s_dude_dash;
	sprite_array_[player.climb] = s_dude_climb;
	sprite_array_[player.ledge_grab] = s_dude_ledge_grab;
	sprite_array_[player.take_damage] = s_dude_take_damage;
	sprite_array_[player.dead] = s_dude_dead;
	sprite_array_[player.interact] = s_dude_interact;
	sprite_array_[player.power_up] = s_dude_power_up;
	*/

	script_array_[player.idle] = player_idle;
	script_array_[player.run] = player_run;
	script_array_[player.jump] = player_jump;
	script_array_[player.fall] = player_fall;
	script_array_[player.attack] = player_attack;
	script_array_[player.slash] = player_slash;
	script_array_[player.uppercut] = player_uppercut;
	script_array_[player.slam] = player_slam;
	script_array_[player.wall_grab] = player_wall_grab;
	script_array_[player.wall_launch] = player_wall_launch;
	script_array_[player.grapple] = player_grapple;
	script_array_[player.dodge] = player_dodge;
	script_array_[player.double_jump] = player_double_jump;
	/*
	script_array_[player.shoot] = player_shoot;
	script_array_[player.dash] = player_dash;
	script_array_[player.climb] = player_climb;
	script_array_[player.ledge_grab] = player_ledge_grab;
	script_array_[player.take_damage] = player_take_damage;
	script_array_[player.dead] = player_dead;
	script_array_[player.interact] = player_interact;
	script_array_[player.power_up] = player_power_up;
	*/

	image_xscale = flipped_;

	if (global.last_player_state != _state) { 
		image_index = 0;
		// _log(string(player[_state]));
	}

	if (_state >= 0) {
		script_execute(script_array_[_state]);
		sprite_index = sprite_array_[_state];
		global.last_player_state = _state;
	} else {
		show_message("no state_ for " + string(_state));
	}



}
