extends Button

func _process(delta:float) -> void:
	visible = not get_tree().paused
