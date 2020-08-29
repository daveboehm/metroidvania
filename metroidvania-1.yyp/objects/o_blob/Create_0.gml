/// @description Blob Enemy

// Movement Values
movementSpeed = 1.5;
hsp = 0;
vsp = 0;
groundFriction = 0.3;
airFriction = 0;
currentFriction = airFriction;
gravityRate = 0;
maxGravity = 0;

hDir = 0;
vDir = 0;
flip = 1;
spin = 0;

maxHealth = 5;
currentHealth = maxHealth;
invincible = false;
invincibilityDuration = 0.1;
bounceAmount = 2.3;
shootCooldown = global.oneSecond*2;

enum alarms {
	invincible,
	shootCooldown
};

state = new StateMachine("idle", 
	"idle", {
		enter: function() {
			alarm[alarms.shootCooldown] = shootCooldown;
		},
		step: function() {
			if (withinDistance(o_dude, 250)) {
				setState("chase");
			}
		}
	},
	"chase", {
		enter: function() {
			// alarm[alarms.shootCooldown] = shootCooldown;
		},
		step: function() {
			moveToward(o_dude, movementSpeed, o_solid);
		}
	},
	"shoot", {
		enter: function() {
			var bullet = instance_create_layer(x, y, "Instances", o_enemy_damage_entity);
			o_enemy_damage_entity.sprite_index = s_blob_bullet;
			bullet.direction = point_direction(x, y, lerp(bullet.x, o_dude.x, .3), lerp(bullet.y, o_dude.y, .3));
			bullet.speed = 2;
			bullet.damage = 1;
			bullet.knockback = 5;
			alarm[alarms.shootCooldown] = shootCooldown;
		},
		step: function() {
			setState("idle");
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