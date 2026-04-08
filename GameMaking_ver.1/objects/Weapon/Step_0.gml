// 1. 주인 추적 (플레이어 위치로 이동)
if (instance_exists(owner)) {
    x = owner.x;
    y = owner.y;
	
    // 마우스 방향을 바라보게 설정 (세피로스 스타일의 긴 검 궤적)
    if (!is_attacking) image_angle = point_direction(x, y, mouse_x, mouse_y);
	
	// 좌우 반전 처리 (하나만 사용!)
    if (image_angle > 90 && image_angle < 270) {
        image_yscale = -1; // 왼쪽을 볼 때 검날 방향 유지
        image_xscale = 1;  // xscale은 건드리지 않음
    } else {
        image_yscale = 1;  // 오른쪽을 볼 때 정상
        image_xscale = 1;
    }
}

// 2. 공격 시작 (마우스 클릭 시)
if (mouse_check_button_pressed(mb_left) && !is_attacking) {
    is_attacking = true;
    sprite_index = Weapon_Sword_Attack; // 공격 애니메이션 교체
    image_index = 0;                // 첫 프레임부터 시작
    ds_list_clear(hit_list);        // 맞은 적 목록 초기화
}

if (is_attacking) {
	/*
	// 2프레임마다 잔상 생성
    if (image_index % 2 == 0) { 
        var _trail = instance_create_layer(x, y, "Instances", obj_sword_trail);
        
        // [중요!] 현재 검의 모든 상태를 잔상에게 복사
        _trail.sprite_index = sprite_index; 
        _trail.image_index = image_index;   
        _trail.image_angle = image_angle;   
        
        // 이 두 줄이 핵심입니다! 현재 반전 상태를 그대로 전달하세요.
        _trail.image_xscale = image_xscale; 
        _trail.image_yscale = image_yscale; 
        
        // 잔상 색깔을 입히고 싶다면 추가 (선택 사항)
        //_trail.image_blend = c_aqua; 
    }
	*/
	
	// 3. 충돌 감지 및 데미지 (공격 중일 때만 실행)
    var _inst = instance_place(x, y, obj_monster); // 몬스터와 닿았는지 확인
    
    // 닿은 대상이 있고, 아직 이번 공격에 맞지 않았다면
    if (_inst != noone && ds_list_find_index(hit_list, _inst) == -1) {
        _inst.hp -= damage;         // 몬스터 체력 감소
        _inst.image_blend = c_red;  // 피격 연출 (빨간색)
        _inst.alarm[0] = 10;        // 10프레임 뒤 색상 복구용 알람
        
        ds_list_add(hit_list, _inst); // 명단에 추가해서 중복 타격 방지
    }
}