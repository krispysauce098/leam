extends Window

#WHY BOTHER? - L10110, Spaceship1842, Zacksio1842, Boine

signal reset
signal changelog_show


func _on_reset_save_pressed():
	emit_signal("reset")


func _on_changelog_pressed():
	emit_signal("changelog_show")
