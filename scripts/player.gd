extends Area2D

# Signals
signal player_move
signal player_stop_move
signal cooldown_start
signal cooldown_end

# Declare member variables here.
var speed = 7
var screen_size
var i = Input
var speeds: float = 1
var cooldown: bool = false
var health: float = 100
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	print(screen_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var s = $sprite.texture
	var dad
	var sett = load("user://settings.res")
	speed = sett.speed
	
	#inconvenient skin switching.
	if sett.dad == 1:
		$sprite.visible = true
		s = load("res://assets/textures/player/default.svg")
		$Tisten.visible = false
		$Bossy.visible = false
		$Rady.visible = false
		$"Speed-cooldown".visible = false
		$Tisten.visible = false
		dad = $sprite
	if sett.dad == 2:
		$sprite.visible = true
		s = load("res://assets/textures/player/og.svg")
		$Tisten.visible = false
		$Bossy.visible = false
		$Rady.visible = false
		$"Speed-cooldown".visible = false
		$Tisten.visible = false
		dad = $sprite
	if sett.dad == 3:
		$sprite.visible = true
		s = load("res://assets/textures/player/10110.svg")
		$Tisten.visible = false
		$Bossy.visible = false
		$Rady.visible = false
		$"Speed-cooldown".visible = false
		$Tisten.visible = false
		dad = $sprite
	if sett.dad == 4:
		$sprite.visible = false
		$Bossy.visible = true
		$Tisten.visible = false
		$Rady.visible = false
		$"Speed-cooldown".visible = false
		$Tisten.visible = false
		dad = $Bossy
	if sett.dad == 5:
		$sprite.visible = false
		$Rady.visible = true
		$Tisten.visible = false
		$Bossy.visible = false
		$"Speed-cooldown".visible = false
		$Tisten.visible = false
		dad = $Rady
	if sett.dad == 6:
		$sprite.visible = false
		$"Speed-cooldown".visible = true
		$Tisten.visible = false
		$Bossy.visible = false
		$Rady.visible = false
		$Tisten.visible = false
		dad = $"Speed-cooldown"
	if sett.dad == 7:
		$sprite.visible = false
		$Tisten.visible = true
		$Bossy.visible = false
		$Rady.visible = false
		$"Speed-cooldown".visible = false
		dad = $Tisten
	
	screen_size = get_viewport_rect().size
	
	## THe direction of input
	var input_dir = Input.get_vector("move-left", "move-right", "move-up","move-down")
	velocity = input_dir
	$sprite.texture = s
	
	# Player rotation handling.
	if i.is_action_pressed("move-down"):
		dad.rotation = 0
	if i.is_action_pressed("move-up"):
		dad.rotation = 0
	if i.is_action_pressed("move-left"):
		dad.rotation = 25
	if i.is_action_pressed("move-right"):
		dad.rotation = -25
	
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
		position += velocity.normalized() * speed * speeds
		emit_signal("player_move")
	else:
		emit_signal("player_stop_move")
		dad.rotation = 0
	
	# Prevents the player from going out of the screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_cooldown_start():
	cooldown = true
	await get_tree().create_timer(10).timeout
	cooldown = false
	emit_signal("cooldown_end")


func _on_playeri_body_entered(body):
	emit_signal("body_entered")
