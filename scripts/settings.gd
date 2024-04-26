extends Window

#WHY BOTHER? - L10110, Spaceship1842, Zacksio1842, Boine

signal reset
signal changelog_show

func _process(delta):
	if $TabBar.current_tab == 0: # The player tab
		$V2.visible = true
		$V.visible = false
	if $TabBar.current_tab == 1: # The misc tab
		$V2.visible = false
		$V.visible = true

func _on_reset_save_pressed():
	emit_signal("reset")


func _on_changelog_pressed():
	emit_signal("changelog_show")


func _on_tab_bar_tab_clicked(tab):
	$TabBar.current_tab = tab
