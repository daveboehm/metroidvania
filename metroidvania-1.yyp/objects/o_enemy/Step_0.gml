/// @description Base Enemy step event
flip = sign(hsp) == 0 ? flip : sign(hsp);
state.step();