image_alpha -= 0.1; // 매 프레임마다 투명해짐 (숫자가 크면 빨리 사라짐)
if (image_alpha <= 0) instance_destroy(); // 완전히 투명해지면 삭제