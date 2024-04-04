extends CanvasLayer

func load_achievement(path: String):
	var ch = load(path)
	if ch.complete == false:
		$Panel/tits.text = ch.title
		$Panel/des.text = ch.description
		$Panel.show()
		await get_tree().create_timer(10).timeout
		$Panel.hide()
		ch.complete = true
		ResourceSaver.save(ch, str(path))
