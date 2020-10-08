/// @description Base Enemy Obj
maxHealth = 1;
currentHealth = maxHealth;
damage = 1;
knockback = 1;
aggroRange = 100;
movementSpeed = 1;
targets = [o_dude];
groundFriction = 0.3;
airFriction = 0;
currentFriction = airFriction;
gravityRate = global.gravityRate;
gravityMax = global.gravityMax;
invincible = false;
invincibilityDuration = 0.5; // In Seconds
bounceAmount = 1.2;
