extends CanvasLayer

@onready var game = get_node("../..")
signal quit_press
signal setting_press

# Called when the node enters the scene tree for the first time.
func _ready():
	print(game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_quit_button_pressed():
	emit_signal("quit_press")


func _on_play_button_pressed():
	game.newgame()

func set_last_score(ls):
	$LastScore.set_text("Last Score:" + ls)

func set_best_score(bs):
	$BestScore.set_text("Best Score:" + bs)


func _on_settings_button_pressed():
	emit_signal("setting_press")
