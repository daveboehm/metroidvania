draw_set_color(c_black);
draw_rectangle(1, 1, 229, 69, false);
draw_set_color(c_white);
draw_rectangle(0, 0, 230, 70, true);

var _state = get_current_state(id);
_state = string_upper(string_char_at(_state, 1)) + string_copy(_state, 2, string_length(_state)-1);
draw_text_color(10, 10, "Current State: " + _state, c_white, c_white, c_white, c_white, 1);
draw_text_color(10, 20, "Flip: " + string(flip), c_white, c_white, c_white, c_white, 1);