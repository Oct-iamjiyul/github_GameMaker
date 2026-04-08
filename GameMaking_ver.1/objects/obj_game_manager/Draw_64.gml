draw_set_font(-1); // 기본 폰트 사용 (나중에 만든 폰트가 있다면 이름 넣기)
draw_set_halign(fa_right);
draw_set_valign(fa_top);

// 텍스트 그림자 효과 (검은색으로 먼저 살짝 옆에 그림)
draw_set_color(c_black);
draw_text(display_get_gui_width() - 18, 22, "KILLS: " + string(global.kill_count));

// 실제 텍스트 (흰색)
draw_set_color(c_white);
draw_text(display_get_gui_width() - 20, 20, "KILLS: " + string(global.kill_count));