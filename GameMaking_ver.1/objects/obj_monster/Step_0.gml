// --- [1단계: 사망 및 피격 연출] ---
if (hp <= 0 && !is_dead) { // 처음 죽는 순간에만 실행되도록 !is_dead 체크
    is_dead = true;
    
    // ★ 킬 카운트 증가
    global.kill_count += 1;
    
    // 죽는 소리나 이펙트 추가 가능
    // audio_play_sound(snd_kill, 1, false);
}

if (is_dead) {
    image_alpha -= 0.05;
    image_blend = c_red;
    if (image_alpha <= 0) instance_destroy();
    exit;
}

// 피격 시 빨간색 반짝임
if (hit_timer > 0) {
    hit_timer--;
    image_blend = c_red;
} else {
    image_blend = c_white;
}

// --- [2단계: 플레이어 추적 및 관통 공격] ---
if (instance_exists(Player_Object)) {
    var _dist = distance_to_object(Player_Object);
    
    switch (state) {
        case "CHASE": 
            // 걷기/추적 애니메이션 적용
            if (sprite_index != Player_Walk_DownRight) { 
                sprite_index = Player_Walk_DownRight;
            }

            var _dir = point_direction(x, y, Player_Object.x, Player_Object.y);
            x += lengthdir_x(move_spd, _dir);
            y += lengthdir_y(move_spd, _dir);
            image_xscale = (Player_Object.x < x) ? -1 : 1;
            
            if (_dist < attack_dist) {
                state = "ATTACK";
                timer = 0;
            }
            break;

        case "ATTACK":
            timer++;

            // [A. 기 모으기 구간: 0~29프레임]
            if (timer < 30) {
                // ★ 기 모으는 동안 대기 모션(Idle) 유지
                if (sprite_index != Player_Idle_DownRight) { 
                    sprite_index = Player_Idle_DownRight; 
                }

                // 노란색 깜빡임 효과 (세피로스 느낌)
                if (timer % 10 < 5) image_blend = c_yellow;
                
                // 기 모으는 동안 플레이어 방향 계속 조준
                attack_dir = point_direction(x, y, Player_Object.x, Player_Object.y);
                image_xscale = (Player_Object.x < x) ? -1 : 1;
            } 
            
            // [B. 공격 시작 시점: 30프레임 딱 한 번]
            else if (timer == 30) {
                // ★ 여기서 공격 애니메이션으로 교체
                sprite_index = Player_Run_DownRight; 
                image_index = 0;
                image_blend = c_white;
                
                // 공격 방향 최종 고정
                attack_dir = point_direction(x, y, Player_Object.x, Player_Object.y);
            }
            
            // [C. 돌진 구간: 30프레임 이상]
            if (timer >= 30) {
                if (image_index > 1 && image_index < 6) {
                    x += lengthdir_x(dash_spd, attack_dir);
                    y += lengthdir_y(dash_spd, attack_dir);
                    
                    if (!instance_exists(obj_enemy_hitbox)) {
                        var _h = instance_create_layer(x, y, "Instances", obj_enemy_hitbox);
                        _h.owner = id;
                    }
                }

                // 애니메이션이 끝나면 다시 추적 상태로
                if (image_index >= image_number - 1) {
                    state = "CHASE";
                    timer = 0;
                }
            }
            break;
		}
} else {
    // 플레이어가 없으면 대기
    state = "CHASE";
}