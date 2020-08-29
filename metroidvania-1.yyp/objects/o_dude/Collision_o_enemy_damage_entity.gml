/// @description Dude gets hit

if (!invincible) { 
	currentHealth -= other.damage;
	direction = point_direction(other.x, other.y, x, y);
	hsp = lengthdir_x(other.knockback, direction);
	vsp = -2;
	setState("hit"); 
}