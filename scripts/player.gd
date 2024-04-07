extends CharacterBody2D

# Signals
signal player_move
signal player_stop_move
signal cooldown_start
signal cooldown_end
signal body_entered

# Declare member variables here.
@export var speed = 400
var screen_size
var i = Input
var speeds: float = 1
var cooldown: bool = false
var health: float = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	screen_size = get_viewport_rect().size
	## THe direction of input
	var input_dir = Input.get_vector("move-left", "move-right", "move-up","move-down")
	velocity = input_dir
	
	# Player rotation handling.
	if i.is_action_pressed("move-down"):
		$sprite.rotation = 0
	if i.is_action_pressed("move-up"):
		$sprite.rotation = 0
	if i.is_action_pressed("move-left"):
		$sprite.rotation = 25
	if i.is_action_pressed("move-right"):
		$sprite.rotation = -25
	
	if i.is_action_just_pressed("speed-1"):
		speeds = 0.5
	if i.is_action_just_pressed("speed-2"):
		speeds = 0.75
	if i.is_action_just_pressed("speed-3"):
		speeds = 1
	if i.is_action_just_pressed("speed-4"):
		if cooldown == false:
			speeds = 1.25
			await get_tree().create_timer(5).timeout
			emit_signal("cooldown_start")
			speeds = 1
	if i.is_action_just_pressed("speed-5"):
		if cooldown == false:
			speeds = 1.5
			await get_tree().create_timer(2.5).timeout
			emit_signal("cooldown_start")
			speeds = 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * speeds
		emit_signal("player_move")
	else:
		emit_signal("player_stop_move")
		$sprite.rotation = 0
	
	# Prevents the player from going out of the screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	move_and_slide()


func _on_cooldown_start():
	cooldown = true
	await get_tree().create_timer(10).timeout
	cooldown = false
	emit_signal("cooldown_end")


func _on_playeri_body_entered(body):
	emit_signal("body_entered")
