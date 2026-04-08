// 몬스터(주인)가 없으면 같이 사라짐
if (!instance_exists(owner)) {
    instance_destroy();
    exit;
}

// 몬스터의 위치와 각도를 실시간으로 따라다님
x = owner.x;
y = owner.y;
image_xscale = owner.image_xscale;
image_angle = owner.image_angle; // 몬스터가 조준하는 방향으로 회전

// 애니메이션이 끝나면 자동으로 삭제 (공격이 끝났으므로)
if (image_index >= image_number - 1) instance_destroy();