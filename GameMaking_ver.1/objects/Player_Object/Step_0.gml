// --- 입력 받기 ---
var _right = keyboard_check(ord("D"));
var _left  = keyboard_check(ord("A"));
var _up    = keyboard_check(ord("W"));
var _down  = keyboard_check(ord("S"));
var _space_hold = keyboard_check(vk_space);
var _space_release = keyboard_check_released(vk_space);

// --- 0. 피격 무적 타이머 계산 ---
if (hit_invincible_timer > 0) {
    hit_invincible_timer--;
    
    // 무적 연출: 캐릭터를 깜빡거리게 만듦
    if (hit_invincible_timer % 10 < 5) image_alpha = 0; 
    else image_alpha = 1;
} else {
    // 무적이 아닐 때는 회피 중이 아니라면 알파값 정상화
    if (!is_rolling) image_alpha = 1; 
}

// --- 1. 넉백(Knockback) 로직 (최우선 처리) ---
if (knockback_speed > 0) {
    // 넉백 방향으로 강제 이동
    x += lengthdir_x(knockback_speed, knockback_dir);
    y += lengthdir_y(knockback_speed, knockback_dir);
    
    // 마찰력으로 속도 감소
    knockback_speed -= 0.5; 
    
    // 넉백 중에는 아래의 회피나 일반 이동을 무시함 (선택 사항)
    // 만약 넉백 중에도 움직이고 싶다면 아래 'exit;'를 지우세요.
    exit; 
}

// --- 2. 이동 벡터 및 상태 계산 (기존 코드 시작) ---
var _h_input = _right - _left;
var _v_input = _down - _up;
var _is_moving = (_h_input != 0 || _v_input != 0);

// --- 3. 회피(Roll) 로직 ---
if (is_rolling) {
    is_invincible = true; // ★ 회피 시작 시 무적 활성화
    
    x += lengthdir_x(roll_speed, roll_dir);
    y += lengthdir_y(roll_speed, roll_dir);
    
    // 무적 연출: 캐릭터를 반투명하게 만듦 (선택 사항)
    image_alpha = 0.5;

    roll_timer--;
    if (roll_timer <= 0) {
        is_rolling = false;
        is_invincible = false; // ★ 회피 종료 시 무적 해제
        image_alpha = 1.0;     // 투명도 복구
    }
}
else {
    // --- 4. 스페이스바 판정 (회피 vs 달리기) ---
    if (_space_release && space_timer < 60 && _is_moving) {
        // 1초 미만으로 누르고 뗐을 때 + 이동 중일 때 = 회피!
        is_rolling = true;
        roll_timer = roll_duration;
        roll_dir = point_direction(0, 0, _h_input, _v_input);
        space_timer = 0;
    }

    if (_space_hold) {
        space_timer++;
        if (space_timer >= 60) {
            is_running = true;
            current_speed = run_speed;
        }
    } else {
        space_timer = 0;
        is_running = false;
        current_speed = walk_speed;
    }

    // --- 5. 일반 이동 처리 ---
    if (_is_moving) {
        var _move_dir = point_direction(0, 0, _h_input, _v_input);
        x += lengthdir_x(current_speed, _move_dir);
        y += lengthdir_y(current_speed, _move_dir);
    }
}

// --- 6. 마우스 조준 (방향 결정) ---
var _mouse_dir = point_direction(x, y, mouse_x, mouse_y);
if (_mouse_dir >= 0 && _mouse_dir < 90)       face = 1; // 우상
else if (_mouse_dir >= 90 && _mouse_dir < 180)  face = 2; // 좌상
else if (_mouse_dir >= 180 && _mouse_dir < 270) face = 3; // 좌하
else                                            face = 0; // 우하

// --- 7. 최종 스프라이트 적용 ---
if (is_rolling) {
    sprite_index = roll_sprites[face];
} else if (_is_moving) {
    if (is_running) {
        sprite_index = run_sprites[face];
    } else {
        sprite_index = walk_sprites[face];
    }
} else {
    sprite_index = idle_sprites[face];
}

// --- 화면 밖으로 나가지 못하게 제한 (Clamp) ---
// 캐릭터 크기만큼 여백 설정 (캐릭터가 64x64라면 32 정도가 적당함)
var _margin = 32; 

// 1. 왼쪽은 0보다 크게, 오른쪽은 화면 너비보다 작게
x = clamp(x, _margin, room_width - _margin);

// 2. 위쪽은 0보다 크게, 아래쪽은 화면 높이보다 작게
y = clamp(y, _margin, room_height - _margin);

// --- 8. 사망 처리 (HP가 0 이하일 때) ---
if (hp <= 0) {
    // 1. 사망 이펙트 (폭발이나 연기 등) 생성 (선택 사항)
    // instance_create_layer(x, y, "Instances", obj_death_effect);
    
    // 2. 게임 오버 오브젝트 생성 (잠시 후 설명)
    if (!instance_exists(obj_game_over)) {
        instance_create_layer(0, 0, "Instances", obj_game_over);
    }
    
    // 3. 플레이어 자신은 삭제 (화면에서 사라짐)
    instance_destroy();
}