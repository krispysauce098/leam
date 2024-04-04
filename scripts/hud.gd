extends CanvasLayer

@onready var game = get_node("../..")
signal quit_press
signal setting_press

# Called when the node enters the scene tree for the first time.
func _ready():
	print(game)
	$Panel/C/GP.set_text(str("Games Played: ", game.games_played))
	$Panel/C/BS.set_text(str("Best Score: ", game.bestScore))
	$Panel/C/ALD.set_text(str("All Lasers Dodged: ", game.all_lasers_dodged))
	$Panel/C/BLD.set_text(str("Best Lasers Dodged: ", game.best_lasers_dodged))
	$Panel/C/ATBS.set_text(str("All Tisten Bolts Survived: ", game.all_tisten_bolts_survived))
	$Panel/C/BTBS.set_text(str("Best Tisten Bolts Survived: ", game.best_tisten_bolts_survived))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Panel/C/GP.set_text(str("Games Played: ", game.games_played))
	$Panel/C/BS.set_text(str("Best Score: ", game.bestScore))
	$Panel/C/ALD.set_text(str("All Lasers Dodged: ", game.all_lasers_dodged))
	$Panel/C/BLD.set_text(str("Best Lasers Dodged: ", game.best_lasers_dodged))
	$Panel/C/ATBS.set_text(str("All Tisten Bolts Survived: ", game.all_tisten_bolts_survived))
	$Panel/C/BTBS.set_text(str("Best Tisten Bolts Survived: ", game.best_tisten_bolts_survived))

func _on_quit_button_pressed():
	emit_signal("quit_press")


func _on_play_button_pressed():
	game.newgame()

func _on_settings_button_pressed():
	emit_signal("setting_press")


func _on_button_pressed():
	$Panel.visible = false


func _on_stat_button_pressed():
	$Panel.visible = true
