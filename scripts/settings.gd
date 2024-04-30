extends Window

#WHY BOTHER? - L10110, Spaceship1842, Zacksio1842, Boine
var save: SettingStore
signal reset
signal changelog_show

func _ready():
	save = load("user://settings.res")
	print(save.speed, ", ", save.dad)
	if save == null:
		save = SettingStore.new()
		ResourceSaver.save(save, "user://settings.res")
	$V2/OptionButton.selected = save.dad
	$V2/H/speed.value = save.speed

func _process(delta):
	# Tabs
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


func _on_speed_changed():
	save.speed = $V2/H/speed.value
	print(save.speed, ", ", save.dad)


func _on_visibility_changed():
	ResourceSaver.save(save, "user://settings.res")
	print(save.speed, ", ", save.dad)


func _on_option_button_item_selected(index):
	save.dad = $V2/OptionButton.selected
	print(save.speed, ", ", save.dad)


func _on_speed_value_changed(value):
	save.speed = $V2/H/speed.value
	print(save.speed, ", ", save.dad)
