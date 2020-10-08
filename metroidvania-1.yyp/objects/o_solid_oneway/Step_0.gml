if (instance_exists(o_dude)) {
	currentSprite = s_platform;
	passThroughCondition = (o_dude.y >= y);
	// OR player collision mask overlapping platform mask
	// OR Player is in "Drop" state, which would trigger the overlap condition as well

	mask_index = passThroughCondition ? mask_index = -1 : mask_index = s_platform;
}