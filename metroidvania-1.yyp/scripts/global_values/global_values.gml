function globalValues() {
	global.oneSecond = game_get_speed(gamespeed_fps);
	global.gravityRate = global.oneSecond/160;
	global.gravityMax = global.oneSecond/5;
	
	
	global.last_player_state = noone;
	global.player_start_position = noone;


}
