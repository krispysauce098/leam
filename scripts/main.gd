extends Node

@onready var fox43 = get_node("Fox43")
@onready var player = get_node("Player")
@onready var f43mp = get_node("Fox43MovePath/Fox43Point")
@onready var chapa = get_node("UI/HUD/AchievementPanel")
var currentScore: int = 0
var distance: int = 0
var bestScore:int = 0 # I need to save this on a file, later on a file which is backed up to the cloud. 
var playing: bool = false
var firstplay: bool = true
var foxblast: bool = false
var pausest: bool = false
## The scene for the asteroid
@export var asteroid_scene: PackedScene
@onready var asteroid = asteroid_scene.instantiate()
var tisten: int
var save = GameSave.new()
var saved = load("user://save.res")

# Analytics
var games_played: int
var all_lasers_dodged: int
var last_lasers_dodged: int
var best_lasers_dodged: int
var all_tisten_bolts_survived: int
var last_tisten_bolts_survived: int
var best_tisten_bolts_survived: int

# Signals
signal gamenew
signal overgame

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Spaceship booted up, an imposter is among us. Hardware Version: AP-10-0")
	player.set_process(false)
	player.visible = false
	player.position = $Startpos.position
	f43mp.progress_ratio = 0.5
	fox43.position = f43mp.position
	fox43.set_process(false)
	fox43.visible = false
	
	# For load
	load_game()

	$UI/MainMenu.visible = true
	$SpawnTimer.start()
	
	if firstplay == false:
		$HFTP.hide()
	

func gameover(code: int, reason: String):
	print("Spaceship ate at starbucks, order: ", str(code)," Reason: ", reason)
	currentScore = currentScore + distance + last_tisten_bolts_survived
	playing = false
	if currentScore > bestScore:
		bestScore = currentScore
	if last_lasers_dodged > best_lasers_dodged:
		best_lasers_dodged = last_lasers_dodged
	if last_tisten_bolts_survived > best_tisten_bolts_survived:
		best_tisten_bolts_survived = last_tisten_bolts_survived
	$UI/HUD/PauseMenu.visible = false
	firstplay = false
	resume()
	player.position = $Startpos.position
	$ScoreTimer.stop()
	f43mp.progress_ratio = randf()
	fox43.position = f43mp.position
	$UI/HUD.visible = false
	$UI/MainMenu.visible = true
	distance = 0
	$UI/HUD.distance_show(str(distance))
	
	# To combat Bug #2
	player.set_physics_process(false)
	player.visible = false
	
	# Print analytics
	print("Games Played: ", games_played)
	print("All lasers dodged: ", all_lasers_dodged)
	print("Last lasers dodged: ", last_lasers_dodged)
	print("Best lasers dodged: ", best_lasers_dodged)
	print("All tisten bolts survived: ", all_tisten_bolts_survived)
	print("Last tisten bolts survived: ", last_tisten_bolts_survived)
	print("Best tisten bolts survived: ", best_tisten_bolts_survived)
	
	save_game()

func newgame():
	playing = true
	print("AP-1-110 is ready to launch! BPHUUUUUUU!!!!")
	games_played += 1
	player.set_physics_process(true)
	fox43.set_process(true)
	player.visible = true
	fox43.visible = true
	resume()
	if firstplay == true:
		f43mp.progress_ratio = 0.5
		fox43.position = f43mp.position
	$RPEmitter.emitting = true
	$Fox43AttackTimer.start()
	$Fox43AttackTimer/Fox43ReadyTimer.wait_time = $Fox43AttackTimer.wait_time / 3 / 0.75
	$ScoreTimer.start()
	$SpawnTimer.wait_time = randf_range(0.5, 1)
	$Fox43AttackTimer/Fox43ReadyTimer.start()
	print("Fox43AttackTimer started")
	print("Fox43ReadyTimer started")
	$Fox43/rady.visible = true
	$Fox43/LaserDie2.disabled = false
	$Fox43/Laser.visible = false
	$Fox43/LaserDie.disabled = true
	$UI/MainMenu.visible = false
	$UI/HUD.visible = true
	currentScore = 0
	last_lasers_dodged = 0
	last_tisten_bolts_survived = 0
	
func pause():
	pausest = true
	$UI/HUD/PauseMenu.visible = true
	$Fox43.set_process(false)
	$Player.set_process(false)
	$Fox43AttackTimer.paused = true
	$Fox43AttackTimer/Fox43ReadyTimer.paused = true
	$Fox43AttackTimer/Fox43LaserTimer.paused = true
	$Fox43AttackTimer/Fox43MoveTimer.paused = true
	$ScoreTimer.paused = true
	$SpawnTimer.paused = true
	$RPEmitter.speed_scale = 0
	$Stars.speed_scale = 0
	get_tree().call_group("asteroid", "set_gravity_scale", 0)

func resume():
	pausest = false
	$UI/HUD/PauseMenu.visible = false
	$Fox43.set_process(true)
	$Player.set_process(true)
	$Fox43AttackTimer.paused = false
	$Fox43AttackTimer/Fox43ReadyTimer.paused = false
	$Fox43AttackTimer/Fox43LaserTimer.paused = false
	$Fox43AttackTimer/Fox43MoveTimer.paused = false
	$ScoreTimer.paused = false
	$SpawnTimer.paused = false
	$RPEmitter.speed_scale = 64
	$Stars.speed_scale = 1

func setting_menu():
	pass

func save_game():
	save.best_score = bestScore
	save.all_tisten_bolts_survived = all_tisten_bolts_survived
	save.best_lasers_dodged = best_lasers_dodged
	save.best_tisten_bolts_survived = best_tisten_bolts_survived
	save.first_play = firstplay
	save.games_played = games_played
	save.all_lasers_dodged = all_lasers_dodged
	save.best_lasers_dodged = best_lasers_dodged
	var sucess = ResourceSaver.save(save, "user://save.res")
	assert(sucess == OK)
	print("Sucess: ", sucess)

func load_game():
	var dem = ResourceLoader.load("user://save.res","",ResourceLoader.CACHE_MODE_IGNORE)
	if dem == null:
		save = GameSave.new()
	else:
		save = dem
	bestScore = save.best_score
	all_tisten_bolts_survived = save.all_tisten_bolts_survived
	best_lasers_dodged = save.best_lasers_dodged
	best_tisten_bolts_survived = save.best_tisten_bolts_survived
	firstplay = save.first_play
	games_played = save.games_played
	all_lasers_dodged = save.all_lasers_dodged
	best_lasers_dodged = save.best_lasers_dodged

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	$RPEmitter.position = $Player.position
	$Debris.position = $Player.position
	$BlastedDebris.position = $Player.position
	var asteroid_spwan_location = get_node("AsteroidPath/AsteroidSpawnPoint")
	var directon = asteroid_spwan_location.rotation + PI / 2
	var velocity = Vector2(435.0, 0.0)
	asteroid.position += velocity.rotated(directon)
	if tisten == 110:
		tisten = 110
		$UI/HUD/tisten.visible = true
		await get_tree().create_timer(randf_range(30, 60)).timeout
		tisten = 1
		all_tisten_bolts_survived += 1
		last_tisten_bolts_survived += 1
	else:
		tisten = randi_range(0, 1000)
		$UI/HUD/tisten.visible = false
	if playing == false:
		$RPEmitter.emitting = false
	if playing == true:
		if Input.is_action_just_released("pause"):
			pause()
	if player.visible == true:
		if $UI/MainMenu.visible == true:
			print("Bug #2 Detected.")
			gameover(3, "Forgot it was not on a mission.")
	pass


func _on_fox_43_attack_timer_timeout():
	print("Fox43AttacTimer timeout")
	if playing == true:
		var rand = randi_range(0,10)
		if rand == 0:
			f43mp.progress_ratio = randf()
			print("Fox43Point progress set to ", f43mp.get_progress(), ", the ratio is ", f43mp.get_progress_ratio(), ".")
			fox43.position = f43mp.position
		else:
			f43mp.set_position(Vector2($Player.position.x, 0))
			print("Fox43Point progress set to ", f43mp.get_progress(), ", the ratio is ", f43mp.get_progress_ratio(), ".")
			fox43.position = f43mp.position
	if playing == false:
		f43mp.progress_ratio = randf()
		print("Fox43Point progress set to ", f43mp.get_progress(), ", the ratio is ", f43mp.get_progress_ratio(), ".")
		fox43.position = f43mp.position
	$Fox43AttackTimer.start()
	$Fox43AttackTimer/Fox43ReadyTimer.wait_time = $Fox43AttackTimer.wait_time / 3 / 0.75
	$Fox43AttackTimer/Fox43ReadyTimer.start()
	print("Fox43MoveTimer started")
	print("Fox43ReadyTimer started")
	$Fox43/rady.visible = true
	$Fox43/LaserDie2.disabled = false
	$Fox43/Laser.visible = false
	$Fox43/LaserDie.disabled = true
	foxblast = false
	if playing == true:
		currentScore += 1
		all_lasers_dodged += 1
		last_lasers_dodged += 1


func _on_fox_43_ready_timer_timeout():
	print("Fox43ReadyTimer timeout. This timer times out 2 times, not expected. Bug #1")
	$Fox43AttackTimer/Fox43LaserTimer.start()
	$Fox43/Laser.visible = true
	$Fox43/LaserDie.disabled = false
	foxblast = true
	$Fox43/rady.visible = false
	$Fox43/LaserDie2.disabled = true


func _on_fox_43_laser_tmer_timeout():
	print("Fox43LaserTimer timeout. This timer times out multiple times")
	#$Fox43/Laser.visible = false
	#$Fox43/LaserDie.disabled = true


func _on_fox_43_area_entered(area):
	if playing == true:
		if area == get_node("Player"):
			player.set_process(false)
			player.visible = false
			$RPEmitter.emitting = false
			if foxblast == true:
				$BlastedDebris.emitting = true
			else:
				$BlastedDebris.emitting = false
			$Player/Blasted.playing = true
			playing = false
			await get_tree().create_timer(randf_range(1, 1.5)).timeout
			gameover(1, "Player got blinded by a mini death star")

func _on_score_timer_timeout():
	distance += 1
	$UI/HUD.distance_show(str(distance))
	print(distance)
	$ScoreTimer.start()


func _on_spawn_timer_timeout():
	print("Tisten Bolt Number: ", tisten)
	if tisten == 110:
		$SpawnTimer.wait_time = randf_range(0.01, 0.3)
		print("Spaceship slept and discovered he was in a Tisten Bolt")
	else:
		$SpawnTimer.wait_time = randf_range(0.25, 0.75)
	$SpawnTimer.start()
	
	var asteroid = asteroid_scene.instantiate()
	
	var asteroid_spwan_location = get_node("AsteroidPath/AsteroidSpawnPoint")
	asteroid_spwan_location.progress_ratio = randf()
	
	asteroid.position = asteroid_spwan_location.position
	
	var directon = asteroid_spwan_location.rotation + PI / 2
	
	directon += PI
	
	var velocity = Vector2(435.0, 0.0)
	
	add_child(asteroid)
	
	if asteroid.bossy == 1:
		$UI/HUD/AchievementPanel.load_achievement("res://achievements/bossy.tres")

func _on_player_body_entered(body):
	if playing == true:
		var b
		player.set_physics_process(false)
		player.visible = false
		$Debris.emitting = true
		$RPEmitter.emitting = false
		$Player/Crushed.playing = true
		b = body
		playing = false
		await get_tree().create_timer(randf_range(3, 5)).timeout
		gameover(2, str(b, " has said hello to the player"))


func _on_fox_43_body_entered(body):
	if fox43.visible == true:
		if body == get_node("Player"):
			player.set_physics_process(false)
			player.visible = false
			$RPEmitter.emitting = false
			if foxblast == true:
				$BlastedDebris.emitting = true
			else:
				$BlastedDebris.emitting = false
			$Player/Blasted.playing = true
			playing = false
			await get_tree().create_timer(randf_range(1, 1.5)).timeout
			gameover(1, "Player got blinded by a mini death star")
		if body == asteroid:
			var pelican: int = randi_range(1, 3)
			if pelican == 2:
				body.queue_free()


func _on_fox_43_move_timer_timeout():
		$Fox43AttackTimer/Fox43MoveTimer.start()
		if foxblast == false:
			f43mp.set_position(Vector2($Player.position.x, 0))
			print("Fox43Point progress set to ", f43mp.get_progress(), ", the ratio is ", f43mp.get_progress_ratio(), ".")
			fox43.position = f43mp.position

func _on_menu_press():
	save_game()
	gameover(3, "Player gone to the main menu that served space meat")


func _on_pause_menu_quit_press():
	save_game()
	get_tree().quit()


func _on_main_menu_quit_press():
	save_game()
	get_tree().quit()


func _on_hftp_close_requested():
	$HFTP.hide()


func _on_settings_reset():
	save.all_lasers_dodged = 0
	save.all_tisten_bolts_survived = 0
	save.best_lasers_dodged = 0
	save.best_score = 0
	save.best_tisten_bolts_survived = 0
	save.first_play = true
	save.games_played = 0
	save_game()
	load_game()
	$HFTP.show()
	$UI/Settings.hide()
	get_tree().call_group("asteroid", "queue_free")
	gameover(4, "Player broke his spaceship")
	get_tree().quit(1)
	


func _on_settings_close_requested():
	$UI/Settings.hide()


func _on_main_menu_setting_press():
	$UI/Settings.show()


func _on_pause_menu_setting_press():
	$UI/Settings.show()


func _on_settings_changelog_show():
	$UI/changelog.show()


func _on_changelog_close_requested():
	$UI/changelog.hide()

func _on_player_cooldown_start():
	$UI/HUD/scool.visible = true

func _on_player_cooldown_end():
	$UI/HUD/scool.visible = false
