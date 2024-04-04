extends RigidBody2D

var bossy: int = 0

func _on_notifier_screen_exited():
	queue_free()

func _ready():
	var china: int = randi_range(1, 1000000)
	var rsc = randf_range(0.20, 0.30)
	$Sprite.scale = Vector2(rsc, rsc)
	$CollisionPolygon2D.scale = Vector2(rsc, rsc)
	var rot = randf_range(-359, 360)
	$Sprite.rotation = rot
	$CollisionPolygon2D.rotation = rot
	if china == 69:
		$Sprite.visible = false
		$Sprite2.visible = true
		bossy = 1
	else:
		$Sprite.visible = true
		$Sprite2.visible = false
		bossy = 0
	
	if $Sprite2.visible == true:
		bossy = 1
		print("Bossy!")
