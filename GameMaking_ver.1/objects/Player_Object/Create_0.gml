// --- 1. 스프라이트 배열 설정 (0:우하, 1:우상, 2:좌상, 3:좌하) ---
idle_sprites = [Player_Idle_DownRight, Player_Idle_UpRight, Player_Idle_UpLeft, Player_Idle_DownLeft];
walk_sprites = [Player_Walk_DownRight, Player_Walk_UpRight, Player_Walk_UpLeft, Player_Walk_DownLeft];
run_sprites  = [Player_Run_DownRight,  Player_Run_UpRight,  Player_Run_UpLeft,  Player_Run_DownLeft]; // 달리기용 추가
// 회피용 스프라이트가 있다면 추가 (없으면 일단 run_sprites 같이 써도 됩니다)
roll_sprites = [Player_Run_DownRight,  Player_Run_UpRight,  Player_Run_UpLeft,  Player_Run_DownLeft];

// --- 2. 기본 상태 변수 ---
face = 0;              // 바라보는 방향
walk_speed = 4;        // 걷기 속도
run_speed = 7;         // 달리기 속도
current_speed = walk_speed;

// --- 3. 타이머 및 특수 상태 변수 ---
space_timer = 0;       // 스페이스바 누른 시간 체크
is_running = false;    // 달리기 상태 여부
is_rolling = false;    // 회피 상태 여부
roll_speed = 12;       // 회피 속도
roll_duration = 15;    // 회피 지속 시간 (프레임)
roll_timer = 0;        // 회피 진행 카운트
roll_dir = 0;          // 회피 방향

hp = 100;		   // 현재 체력
hp_max = 100;      // 최대 체력
knockback_speed = 0;
knockback_dir = 0;

is_invincible = false; // 무적 상태인지 확인
hit_invincible_timer = 0; // 피격 무적 타이머