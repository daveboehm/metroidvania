/// @param frame
function isFrame(_frame) {
	var _speed = global.oneSecond/sprite_get_speed(sprite_index);
	return (image_index >= _frame+1 - image_speed/_speed) and (image_index < _frame+1);
}

///@description boolean if Other is Threshold pixels or closer
///@param OtherObject
///@param Threshold
function withinDistance(_other, _threshold) {
	var _distance = point_distance(x, y,_other.x, _other.y);
	return _distance <= _threshold;
}

/// @description Movement, Gravity, Approach

/// @param object
/// @param groundSolid
/// @param rate
/// @param maxRate
function applyGravity(_obj, _ground, _rate, _maxRate) {
	if (!on_ground(_obj, _ground)) {
		if (vsp < _maxRate) {
			vsp += _rate; 
		}
	} 
}

function basicMovement() {
	applyGravity(o_dude, o_solid, gravityRate, maxGravity);
	hsp = approach(hsp, (dir * movementSpeed), currentFriction);
	move(o_solid);
}

function ladderMovement() {
	var _vDir = move_down - move_up;
	vsp = _vDir * movementSpeed * 0.5;
	image_speed = abs(vsp);
	hsp = approach(hsp, (dir * movementSpeed/2), currentFriction);
	if (!place_meeting(x + (4*flip), y, o_ladder)) {
		hsp = 0;
	}
	if (!place_meeting(x, y, o_ladder)) {
		state_switch("idle");
	}
	move(o_solid);
}

/// @param collisionObject
function move(_collisionObj) {
	if place_meeting(x + hsp, y, _collisionObj) {
		while !place_meeting(x + sign(hsp), y, _collisionObj) { x += sign(hsp); }
		hsp = 0;
	}
	x += hsp;

	if place_meeting(x, y + vsp, _collisionObj) {
		while !place_meeting(x, y + sign(vsp), _collisionObj) { y += sign(vsp); }
		vsp = 0;
	} 
	y += vsp;
}

/// @description Move entity toward other entity
/// @param TargetEntity
/// @param MoveSpeed
/// @param CollisionObject
function moveToward(_target, _speed, _collisionObj) {
	var _direction = point_direction(x, y, _target.x, _target.y);
	hDir = sign(cos(_direction));
	vDir = sign(sin(_direction));
	hsp = lengthdir_x(_speed, _direction);
	vsp = lengthdir_y(_speed, _direction);
	flip = hDir != 0 ? hDir : flip;
	
	if (place_meeting(x+_speed*hDir, y, _collisionObj)) {
		// while !place_meeting(x + sign(hsp), y, _collisionObj) { x += sign(hsp); }
		hsp = 0;
	}
	
	if (place_meeting(x, y+_speed*vDir, _collisionObj)) {
		//while !place_meeting(x, y + sign(vsp), _collisionObj) { y += sign(vsp); }
		vsp = 0;
	}
	x += hsp;
	y += vsp;
}

/// @param speed
/// @param canBounce
function moveDir(_spd, _bounce) {
	if (is_undefined(_spd)) { _spd = movementSpeed; }
	// Apply friction when sliding on walls
	if place_meeting(x+lengthdir_x(_spd, direction), y+lengthdir_y(_spd, direction), o_solid) and !_bounce {
		_spd = approach(_spd, 0, currentFriction/2);
	}

	var _x_speed = lengthdir_x(_spd, direction);
	var _y_speed = lengthdir_y(_spd, direction);
/*	
	show_message("_x_speed: " + string(_x_speed));
	show_message("_y_speed: " + string(_y_speed));
	show_message("direction: " + string(direction));
*/
	if _spd <= 0 exit; // No need to check for collisions

	if place_meeting(x+_x_speed, y, o_solid) {
		while !place_meeting(x+sign(_x_speed), y, o_solid) {
			x += sign(_x_speed);
		}
	
		if _bounce {
			_x_speed = -(_x_speed)*bounceAmount;
		} else {
			_x_speed = 0;
		}
	
	}
	x += _x_speed;

	if place_meeting(x, y+_y_speed, o_solid) {
		while !place_meeting(x, y+sign(_y_speed), o_solid) {
			y += sign(_y_speed);
		}
	
		if _bounce {
			_y_speed = -(_y_speed)*bounceAmount;
		} else {
			_y_speed = 0;
		}
	
	}
	y += _y_speed;

	// Make sure to update speed and direction
	movementSpeed = point_distance(0, 0, _x_speed, _y_speed);
	direction = point_direction(0, 0, _x_speed, _y_speed);


}

/// @param currentValue
/// @param targetValue
/// @param rate
function approach(_current, _target, _amount) {
	if (_current < _target) {
	    return min(_current + _amount, _target); 
	} else {
	    return max(_current - _amount, _target);
	}
}

/// @param character
/// @param groundObject
function onGround(_char, _ground) {
	return place_meeting(_char.x, _char.y + 1, _ground);
}

/// @param stateToTransitionTo
function setState(_s) {
	var _ownedAbility = state.__get_events(_s);
	if (!is_undefined(_ownedAbility )) { 
		state_switch(_s);
	}
}

///@param value
///@param increment
function roundTo(_value, _increment) {
	return round(_value/_increment) * _increment;
}

///@arg percent
function chance(_percent) {
	return random(1) < _percent;
}

///@arg startingFrame
///@arg endingFrame
function _is_frame_window(_start, _end) {
	return (image_index >= _start) && (image_index <= _end); 
}
	
///@param value
///@param array
function findIndex(_value, _array) {
	var _array_length = array_length(_array);
	for (var _i=0; _i<_array_length; _i++) {
		if _value == _array[_i] { return _i; }
	}
	return -1;
}