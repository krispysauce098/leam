extends CanvasLayer

#signals
signal menu_press
signal setting_press
signal resume_press
signal quit_press

@onready var game = get_node("../../..")

func _on_menu_button_pressed():
	emit_signal("menu_press")


func _on_resume_button_pressed():
	emit_signal("resume_press")


func _on_quit_button_pressed():
	emit_signal("quit_press")
