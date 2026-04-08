// 1. 배경을 약간 어둡게 덮음
alpha = min(alpha + 0.02, 0.7); // 최대 0.7까지 불투명해짐
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// 2. "GAME OVER" 문구 출력
draw_set_alpha(1);
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _cx = display_get_gui_width() / 2;
var _cy = display_get_gui_height() / 2;

draw_text_transformed(_cx, _cy - 20, "GAME OVER", 2, 2, 0);

// 3. 재시작 안내
draw_set_color(c_white);
draw_text(_cx, _cy + 40, "Press 'R' to Restart");

// 4. 'R' 키를 누르면 방 재시작
if (keyboard_check_pressed(ord("R"))) {
    room_restart();
}