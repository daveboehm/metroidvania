globalValues();

maxHealth = 10;
currentHealth = maxHealth;

// Movement Values
movementSpeed = 2.5;
hsp = 0;
vsp = 0;
groundFriction = 0.3;
airFriction = 0.15;
currentFriction = groundFriction;
gravityRate = global.gravityRate;
maxGravity = global.gravityMax;
jumpRate = -.08;
jumpHeight = -6;
dir = 0;
aimDir = 0;
flip = 1;
doubleJumpThreshold = 2.8;

invincible = false;
invincibilityDuration = global.oneSecond*0.2;
knockback = 15;

// Room Changing
nextRoom = noone;
nextDoor = noone;

grapplingHook = {
	startX: x + (3*flip),
	startY: y - 8,
	endX: x + (5*flip),
	endY: y - 15,		
	chainLength: 5,
	chainMaxLength: 100,
	chainAngle: 0,
	chainAngleVelocity: 0
};
			
function throwGrapplingHook() {
	grapplingHook = {
		startX: x + (3*flip),
		startY: y - 8,
		endX: x,
		endY: y,		
		
		chainLength: 5,
		chainMaxLength: 80,
		chainAngle: 0,
		chainAngleVelocity: 0
	};
	var g = grapplingHook;
	while !place_meeting(g.endX, g.endY+10, o_solid) && (g.chainLength < g.chainMaxLength) {
		g.chainLength++;
		var _end_x = lengthdir_x(g.chainLength * flip, aimDir);
		var _end_y = lengthdir_y(g.chainLength, aimDir);
		g.endX = g.startX + (_end_x * flip);
		g.endY = g.startY + _end_y;
	}

	if place_meeting(g.endX, g.endY+10, o_solid) && (g.chainLength < g.chainMaxLength) {
		g.chainAngleVelocity = 0;
		setState("grapplingHook");
	}
}

state = new StateMachine("idle",
	"idle", {
		enter: function() {
			sprite_index = s_dude_idle;
			image_index = 0;
			currentFriction = groundFriction;
		},
		step: function() {
			basicMovement();
			if (hsp != 0) {							
				setState("run");		
			}
			if (btn_A_pressed) {		
				setState("jump");		
			}
			if (btn_X_pressed) {
				setAttack(state.currState);	
			}
			if (btn_B_pressed) {					
				setState("dodge");		
			}
		}
	},
	"run", {
		enter: function() {
			sprite_index = s_dude_run;
			image_index = 0;
			currentFriction = groundFriction;
		},
		step: function() {
			basicMovement();
			
			if (btn_A_pressed) {
				setState("jump");			
			}
			if (btn_X_pressed) {
				setAttack(state.currState);
			}
			if (btn_B_pressed) {		
				setState("dodge");		
			}
			if (hsp == 0) {				
				setState("idle");		
			}
		}
	},
	"jump", {
		enter: function() {
			sprite_index = s_dude_jump;
			image_index = 0;
			currentFriction = airFriction;
			vsp = jumpHeight; 
		},
		step: function() {
			basicMovement();
			if (vsp < 0) {
				if (btn_A_pressed) {
					vsp += jumpRate;
				}
				if (btn_A_released) {
					vsp = 0;
				}
			}
			
			if (vsp >= 0) {
				setState("fall");	
			}
			
			if (btn_X_pressed) {
				setAttack(state.currState);
			}
			if (btn_Y_pressed) {					 
				setState("grapplingHook"); 
			}
		}
	},
	"climb", {
		enter: function() {
			sprite_index = s_dude_climb;
			currentFriction = groundFriction;
		},
		step: function() {
			ladderMovement();
			if (btn_A_pressed) {
				setState("jump");			
			}
			if (btn_B_pressed) {
				setState("fall");			
			}
			if (onGround(o_dude, o_solid)) {
				setState("idle");
			}
		},
		leave: function() {
			image_speed = 1;
		}
	},
	"attack", {
		enter: function() {
			sprite_index = s_dude_slash;
			image_index = 0;
			currentFriction = groundFriction;
			createAttackBox(s_damage_slash, x + (4*flip), y-8, flip, 7, [o_enemy], 1, knockback);
		},
		step: function() {
			basicMovement();
			if isFrame(image_number - 1) { 
				if vsp > 0 {				setState("fall"); }
				else {						setState("idle"); }
			}
		}
	},
	"attackUp", {
		enter: function() {
			sprite_index = s_dude_slash_up;
			image_index = 0;
			currentFriction = groundFriction;
			createAttackBox(s_damage_slash_up, x, y-15, 1, 7, [o_enemy], 1, knockback);
		},
		step: function() {
			basicMovement();
			if isFrame(image_number - 1) { 
				if vsp > 0 {				setState("fall"); }
				else {						setState("idle"); }
			}
		}
	},
	"attackDown", {
		enter: function() {
			sprite_index = s_dude_slash_up;
			image_index = 0;
			currentFriction = groundFriction;
			createAttackBox(s_damage_slash_up, x, y-15, 1, 7, [o_enemy], 1, knockback);
		},
		step: function() {
			basicMovement();
			if isFrame(image_number - 1) { 
				if vsp > 0 {				setState("fall"); }
				else {						setState("idle"); }
			}
		}
	},
	"airAttack", {
		enter: function() {
			sprite_index = s_dude_jump_slash;
			image_index = 0;
			currentFriction = groundFriction;
			createAttackBox(s_damage_slash, x + (4*flip), y-8, flip, 7, [o_enemy], 1, knockback);
		},
		step: function() {
			basicMovement();
			if isFrame(image_number - 1) { 
				if (vsp < 0) {
					if (btn_A_pressed) {
						vsp += jumpRate;
					}
					if (btn_A_released) {
						vsp = 0;
					}
				}
				if vsp > 0 {				
					setState("fall"); 
				}
				else {
					setState("idle"); 
				}
			}
		}
	},
	"airAttackUp", {
		enter: function() {
			sprite_index = s_dude_jump_slash;
			image_index = 0;
			currentFriction = groundFriction;
			createAttackBox(s_damage_slash_up, x, y-15, 1, 7, [o_enemy], 1, knockback);
		},
		step: function() {
			basicMovement();
			if isFrame(image_number - 1) { 
				if (vsp < 0) {
					if (btn_A_pressed) {
						vsp += jumpRate;
					}
					if (btn_A_released) {
						vsp = 0;
					}
				}
				if vsp > 0 {				
					setState("fall"); 
				}
				else {
					setState("idle"); 
				}
			}
		}
	},
	"doubleJump", {
		enter: function() {
			sprite_index = s_dude_tucked;
			image_index = 0;
			currentFriction = airFriction;
			vsp = jumpHeight; 
		},
		step: function() {
			basicMovement();
			if (btn_A_pressed) {
				vsp += jumpRate;
			}
			if (btn_A_released) {
				vsp = 0;
			}
			if (btn_X_pressed) {
				setState("airSpinAttack");
			}
			if (btn_Y_pressed) {	
				throwGrapplingHook();
			}
			
			if (vsp > doubleJumpThreshold) {
				setState("fall");	
			}
		}
	},
	"airSpinAttack", {
		enter: function() {
			sprite_index = s_dude_air_spin_attack;
			image_index = 0;
			invincible = true;
			currentFriction = airFriction;
		},
		step: function() {
			basicMovement();
			createAttackBox(s_damage_air_spin_attack, x, y, 1, 1, [o_enemy], 1, knockback);
			if isFrame(image_number - 1) { 
				hsp = 1.75 * flip;
				invincible = false;
				if vsp > 0 {				setState("fall"); }
				else {						setState("idle"); }
			}
		}
	},
	"fall", {
		enter: function() {
			sprite_index = s_dude_fall;
			image_index = 0;
			currentFriction = airFriction;
		},
		step: function() {
			basicMovement();
			if (vsp < doubleJumpThreshold) {
				if (btn_A_pressed) {					 
					setState("doubleJump"); 
				}
				if (btn_X_pressed) {
					setState("airSpinAttack");
				}
			}
			if (btn_Y_pressed) {	
				throwGrapplingHook();
			}
			if (btn_X_pressed) {						 
				// setState("airSlamAttack");
			}
			if (onGround(o_dude, o_solid)) {	
				setState("idle");		
			}
		}
	},
	"dodge", {
		enter: function() {
			sprite_index = s_dude_dodge;
			image_index = 0;
			currentFriction = groundFriction;
			invincible = true;
		},
		step: function() {
			applyGravity(o_dude, o_solid, gravityRate, maxGravity);
			hsp = movementSpeed * 2 * flip;
			move(o_solid);
			if isFrame(image_number - 1) { 
				hsp = 1.75 * flip;
				invincible = false;
				if vsp > 0 {				setState("fall"); }
				else {						setState("idle"); }
			}
		}
	},
	"hit", {
		enter: function() {
			sprite_index = s_dude_hit;
			image_index = 0;
			currentFriction = airFriction;
			invincible = true;
			game_set_speed(30, gamespeed_fps);
		},
		step: function() {
			applyGravity(o_dude, o_solid, gravityRate, maxGravity);
			move(o_solid);
			if isFrame(image_number - 1) { 
				invincible = false;
				if vsp > 0 {				setState("fall"); }
				else {						setState("idle"); }
			}
		},
		leave: function() {
			game_set_speed(60, gamespeed_fps);
		}
	},
	"grapplingHook", {
		enter: function() {
			sprite_index = s_dude_grapple;
			image_index = 0;
		},
		step: function() {
			var g = grapplingHook;
			show_debug_message("start: "+ string(g.startY));
			g.chainAngle = point_direction(g.endX, g.endY, g.startX, g.startY);
			g.chainLength = point_distance(g.endX, g.endY, g.startX, g.startY);
	
			var _swing_speed = g.chainLength * .015;
			_swing_speed = clamp(_swing_speed, .5, .65);

			var _rope_angle_acceleration = -_swing_speed * dcos(g.chainAngle);
			_rope_angle_acceleration += dir * 0.1;

			g.chainAngleVelocity += _rope_angle_acceleration;
			g.chainAngle += g.chainAngleVelocity;
			g.chainAngleVelocity *= dir == 0 ? 0.95 : 1;
			g.startX = g.endX + lengthdir_x(g.chainLength, g.chainAngle);
			g.startY = g.endY + lengthdir_y(g.chainLength, g.chainAngle);
			
			show_debug_message("end: "+ string(g.startY));

			hsp = g.startX - x;
			vsp = g.startY - y + 8; 

			if !place_meeting(o_dude.x + hsp, o_dude.y + vsp, o_solid) {
				o_dude.x += hsp;
				o_dude.y += vsp;
			} else {
				setState("fall");
			}


			if (btn_Y_released) {
				var _momentum = 2*flip;
	
				if (vsp < .5) {	
					vsp += jumpHeight/1.5;
					hsp += _momentum;
					setState("jump");
				}

				setState("fall");
			}

		}
	}
);
