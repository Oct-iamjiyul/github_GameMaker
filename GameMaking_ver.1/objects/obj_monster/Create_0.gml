// 기본 능력치
hp = 30;
move_spd = 1.5;      // 평소 이동 속도
dash_spd = 10;       // 관통하며 지나가는 속도 (빠르게 설정)

// 상태 및 타이머
state = "CHASE";     // 현재 상태
timer = 0;           // 기 모으기용 타이머
is_dead = false;     // 사망 여부
hit_timer = 0;       // 피격 시 빨간색 반짝임

// 공격 관련
attack_dist = 80;    // 공격 시작 거리
attack_dir = 0;      // 공격 시 고정될 방향