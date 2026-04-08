owner = Player_Object;      // 무기의 주인
damage = 10;             // 공격력
hit_list = ds_list_create(); // 이번 휘두르기에 맞은 적 목록 (중복 방지)
is_attacking = false;    // 현재 공격 중인지 확인

depth = -100;

// 과거의 각도와 위치를 기억할 리스트
trail_list = ds_list_create();
max_trail = 5; // 잔상 개수