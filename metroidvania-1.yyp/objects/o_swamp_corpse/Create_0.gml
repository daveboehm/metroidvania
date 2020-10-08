/// @description Blob Enemy

// Movement Values
movementSpeed = 0.5;
hsp = 0;
vsp = 0;
groundFriction = 0.3;
currentFriction = groundFriction;
gravityRate = global.gravityRate;
maxGravity = global.gravityMax;

hDir = 0;
vDir = 0;
flip = 1;

maxHealth = 5;
currentHealth = maxHealth;
invincible = false;
invincibilityDuration = 0.1;
bounceAmount = 2.3;
attackCooldown = global.oneSecond*3;

enum alarms {
	invincible,
	attack,
};

state = new StateMachine("idle", 
	"idle", {
		enter: function() {
			sprite_index = s_swamp_corpse_idle;
			image_index = 0;
			alarm[alarms.attack] = attackCooldown;
		},
		step: function() {
			if (withinDistance(o_dude, 30)) { 
				setState("attack"); 
			}
			if (withinDistance(o_dude, 150)) {
				setState("run");
			}
		}
	},
	"run", {
		enter: function() {
			sprite_index = s_swamp_corpse_run;
			image_index = 0;
		},
		step: function() {
			if (withinDistance(o_dude, 30)) { 
				setState("attack"); 
			}
			if (!withinDistance(o_dude, 150)) {
				setState("idle");
			}
			moveToward(o_dude, movementSpeed, o_solid);
		}
	},
	"attack", {
		enter: function() {
			sprite_index = s_swamp_corpse_attack;
			image_index = 0;
			createAttackBox(s_swamp_corpse_damage_attack, x+6*flip, y-8, 1, 4, [o_dude], 1, knockback);
		},
		step: function() {
			
		}
	},
	"hit", {
		enter: function() {
			invincible = true;
			alarm[alarms.invincible] = global.oneSecond * invincibilityDuration;
			currentHealth -= other.damage;
		},
		step: function() {
			move(o_solid);
		}
	},
);