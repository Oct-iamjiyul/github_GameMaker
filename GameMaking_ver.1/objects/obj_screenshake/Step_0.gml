// 1. 현재 존재하는 플레이어 찾기 (이름이 Player_Object 인지 확인!)
var _target = Player_Object; 

if (instance_exists(_target)) {
    // 2. 목표 좌표 계산 (플레이어의 중앙)
    var _target_x = _target.x - cam_w_half;
    var _target_y = _target.y - cam_h_half;

    // 3. 맵 밖(검은 배경)을 보여주지 않도록 카메라 위치 제한 (Clamp)
    // 플레이어 코드의 _margin과 연동하여 부드럽게 멈춤
    _target_x = clamp(_target_x, 0, room_width - (cam_w_half * 2));
    _target_y = clamp(_target_y, 0, room_height - (cam_h_half * 2));

    // 4. 현재 카메라 위치 가져오기
    var _curr_x = camera_get_view_x(view_camera);
    var _curr_y = camera_get_view_y(view_camera);

    // 5. 부드러운 추적 (Lerp)
    var _new_x = lerp(_curr_x, _target_x, 0.1);
    var _new_y = lerp(_curr_y, _target_y, 0.1);

    // 6. 화면 흔들림 효과 더하기
    if (shake_amount > 0) {
        _new_x += random_range(-shake_amount, shake_amount);
        _new_y += random_range(-shake_amount, shake_amount);
        shake_amount -= shake_decay;
    }

    // 7. 최종 카메라 위치 적용
    camera_set_view_pos(view_camera, _new_x, _new_y);
}