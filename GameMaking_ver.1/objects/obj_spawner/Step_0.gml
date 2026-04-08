spawn_timer++;

// 1. 타이머가 다 찼고, 맵에 몬스터가 너무 많지 않을 때만 실행
if (spawn_timer >= spawn_delay && instance_number(obj_monster) < max_monsters) {
    
    // 2. 플레이어 위치 확인 (Player_Object 이름 확인!)
    if (instance_exists(Player_Object)) {
        
        // 3. 플레이어 주변 400~600픽셀 사이의 무작위 위치 계산
        // (너무 가까우면 갑자기 나타나서 이상하고, 너무 멀면 안 보임)
        var _dist = random_range(400, 600);
        var _dir = random(360);
        
        var _spawn_x = Player_Object.x + lengthdir_x(_dist, _dir);
        var _spawn_y = Player_Object.y + lengthdir_y(_dist, _dir);
        
        // 4. 맵 밖으로 나가지 않게 제한 (Clamp)
        _spawn_x = clamp(_spawn_x, 100, room_width - 100);
        _spawn_y = clamp(_spawn_y, 100, room_height - 100);
        
        // 5. 몬스터 소환!
        instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_monster);
        
        // 6. 소환 이펙트 (선택 사항 - 연기나 마법진)
        // effect_create_above(ef_smoke, _spawn_x, _spawn_y, 1, c_gray);
    }
    
    spawn_timer = 0; // 타이머 초기화
}