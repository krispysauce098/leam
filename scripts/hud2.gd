extends CanvasLayer

@onready var game = get_node("../..")

# Called when the node enters the scene tree for the first time.
func _ready():
	distance_show("0")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func distance_show(d: String):
	$Distance.text = d


func _on_pause_menu_resume_press():
	$PauseMenu.visible = false
	game.resume()


func _on_pause_pressed():
	$PauseMenu.visible = true
	game.pause()
