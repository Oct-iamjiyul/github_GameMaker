// 1. 잔상 먼저 그리기
for (var i = 0; i < ds_list_size(trail_list); i++) {
    var _d = trail_list[| i];
    // 뒤로 갈수록 더 투명하게 그리기
    draw_sprite_ext(sprite_index, image_index, _d[0], _d[1], image_xscale * 0.9, _d[3], _d[2], c_white, 0.5 - (i * 0.1));
}

// 2. 본체 그리기
draw_self();