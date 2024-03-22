extends RigidBody2D

func _on_notifier_screen_exited():
	queue_free()

func _ready():
	var china: int = 50 #randi_range(1, 110)
	if china == 50:
		$Sprite.visible = false
		$Sprite2.visible = true
	if china == 69:
		$Sprite.visible = false
		$Sprite2.visible = true
	if china == 110:
		$Sprite.visible = false
		$Sprite2.visible = true
	if china == 10:
		$Sprite.visible = false
		$Sprite2.visible = true
	else:
		$Sprite.visible = true
		$Sprite2.visible = false
