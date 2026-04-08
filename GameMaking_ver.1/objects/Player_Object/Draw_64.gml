// --- 1. UI 위치 및 크기 설정 ---
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _bar_w = 240;             // 체력바 가로 길이
var _bar_h = 24;             // 체력바 세로 높이
var _x = (_gui_w / 2) - (_bar_w / 2); // 화면 가로 중앙
var _y = _gui_h - 60;        // 화면 아래에서 60픽셀 위

// --- 2. 값 계산 (음수 방지 및 비율) ---
// hp가 0보다 작아지더라도 0으로 고정해서 표시함 (max 함수 사용)
var _display_hp = max(0, hp); 
var _hp_percent = _display_hp / hp_max;

// --- 3. 체력바 그리기 ---
// (1) 배경 테두리 (검은색)
draw_set_color(c_black);
draw_rectangle(_x - 3, _y - 3, _x + _bar_w + 3, _y + _bar_h + 3, false);

// (2) 비어있는 바 배경 (진한 회색)
draw_set_color(c_dkgray);
draw_rectangle(_x, _y, _x + _bar_w, _y + _bar_h, false);

// (3) 실제 체력 바 (빨간색)
// 비율만큼 가로 길이를 곱해서 그림
draw_set_color(c_red);
draw_rectangle(_x, _y, _x + (_bar_w * _hp_percent), _y + _bar_h, false);

// --- 4. 텍스트 표시 ---
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

// ceil을 사용하여 소수점을 올림하고, 정수로 깔끔하게 표시
var _hp_string = string(ceil(_display_hp)) + " / " + string(hp_max);
draw_text(_x + (_bar_w / 2), _y + 4, _hp_string);

// 그리기 설정 초기화 (다른 UI에 영향을 주지 않기 위해)
draw_set_halign(fa_left);