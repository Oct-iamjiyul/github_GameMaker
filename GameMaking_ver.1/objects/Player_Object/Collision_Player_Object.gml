if (instance_exists(other)) {
    other.hp -= damage;
    
    // 넉백 설정
    var _dir = point_direction(x, y, other.x, other.y);
    other.knockback_dir = _dir;       // 밀려날 방향
    other.knockback_speed = 12;       // 밀려날 힘 (숫자가 클수록 멀리 튕김)
    
    // 타격 연출 (화면 흔들림 등 추가 가능)
    // effect_create_above(ef_star, other.x, other.y, 1, c_white);

    instance_destroy(); // 한 번 때리면 판정 제거
}