

function setAttack(_currentState) {
	var vAttackDir = (move_down - move_up) + 1;
	var idleState = ["attackDown", "attack", "attackUp"];
	var runState = ["attackDown", "attack", "attackUp"];
	var jumpState = ["airAttackDown", "airAttack", "airAttackUp"];
	var doubleJumpState = ["airSpinAttack", "airSpinAttack", "airSpinAttack"];
	var fallState = ["airAttackDown", "airAttack", "airAttackUp"];

	switch(string(_currentState)) {
		case "idle": return setState(idleState[vAttackDir]);
		case "run": return setState(runState[vAttackDir]);
		case "jump": return setState(jumpState[vAttackDir]);
		case "doubleJump": return setState(doubleJumpState[vAttackDir]);
		case "fall": return setState(fallState[vAttackDir]);
		default: setState("idle");
	} 
}

/// @param frameIndex
function animationHitFrame(_frame) {
	var _speed = global.oneSecond/sprite_get_speed(sprite_index);
	return (image_index >= _frame+1 - image_speed/_speed) and (image_index < _frame+1);
}

///@param sprite
///@param x
///@param y
///@param flip
///@param frames
///@param target_array
///@param damage
///@param knockback
function createAttackBox(_spr, _x, _y, _flip, _frames, _array, _damage, _knockback) {
	var atkBox = instance_create_layer(_x, _y, "Instances", o_damage_box);
	atkBox.sprite_index = _spr;
	atkBox.image_xscale = _flip;
	atkBox.alarm[0] = _frames;
	atkBox.targets = _array;
	atkBox.damage = _damage;
	atkBox.knockback = _knockback;

	return atkBox;
}

///@param value
///@param target_array
function is_target(_value, _array) {
	var _array_length = 3; // @TODO: fix - array_length_1d(_array);
	var _index = 0;
	repeat _array_length {
		if _value == _array[_index] return true;
		if object_is_ancestor(_value, _array[_index]) return true;
		_index++;
	}
	return false;
}

///@param hitbox
function hurtbox_entity_can_be_hit_by(_hitbox) {
	var _is_target = is_target(object_index, _hitbox.targets_);
	return !invincible_ and _is_target;
}
