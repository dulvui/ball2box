extends Button

func _process(delta):
	visible = not get_tree().paused
