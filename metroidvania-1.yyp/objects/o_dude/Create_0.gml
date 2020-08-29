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
grapplingHook = {
	startX: x + (3*flip),
	startY: y - 8,
	endX: x + 25*flip,
	endY: y - 25,
	chainLength: 0,
	chainMaxLength: 100,
	chainAngle: 0,
	chainAngleVelocity: 0
};
invincible = false;
invincibilityDuration = global.oneSecond*0.2;
knockback = 15;

// Room Changing
nextRoom = noone;
nextDoor = noone;

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
			
			if (vsp > doubleJumpThreshold) {
				setState("fall");	
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
					setState("airAttack");
				}
				if (btn_Y_pressed) {					 
					setState("grapplingHook"); 
				}
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
		},
		step: function() {
			applyGravity(o_dude, o_solid, gravityRate, maxGravity);
			move(o_solid);
			if isFrame(image_number - 1) { 
				invincible = false;
				if vsp > 0 {				setState("fall"); }
				else {						setState("idle"); }
			}
		}
	},
	"grapplingHook", {
		enter: function() {
			sprite_index = s_dude_grapple;
			image_index = 0;
			grapplingHook = {
				startX: x + (3*flip),
				startY: y - 8,
				endX: x + 25*flip,
				endY: y - 25,
				chainLength: 0,
				chainMaxLength: 100,
				chainAngle: 0,
				chainAngleVelocity: 0
			};
			alarm[0] = 30;
			var g = grapplingHook;
			var _end_x = 3;
			var _end_y = 8;

			
			g.endX = g.startX - (_end_x * flip);
			g.endY = g.startY + _end_y;

			while !place_meeting(g.endX, g.startY, o_solid) && (g.chainLength < g.chainMaxLength) {
				_end_x++;
				_end_y++;
				g.endX = g.startX + (_end_x * flip);
				g.endY = g.startY - _end_y;
				g.chainLength = point_distance(g.endX, g.endY, g.startX, g.startY);
			}

			if place_meeting(g.endX, g.endY, o_solid) && g.chainLength < g.chainMaxLength {
				g.chainAngleVelocity = 0;
				
			} else {
				setState("idle");
			}
			
		},
		step: function() {
			basicMovement();
			

			
		}
	}
);
