// 플레이어가 존재하고 + 회피 무적도 아니고 + 피격 무적도 아닐 때만 데미지
if (instance_exists(other)) {
    if (!other.is_invincible && other.hit_invincible_timer <= 0) {
        
        other.hp -= damage; 
        
        // ★ 피격 무적 시간 1초 설정 (60프레임)
        other.hit_invincible_timer = 60; 

        // 넉백 및 흔들림 처리
        var _dir = point_direction(x, y, other.x, other.y);
        other.knockback_dir = _dir;
        other.knockback_speed = 15;

        if (instance_exists(obj_screenshake)) {
            obj_screenshake.shake_amount = 12;
        }

        instance_destroy(); 
    }
}