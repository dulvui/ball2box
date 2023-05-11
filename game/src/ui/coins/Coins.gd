extends HBoxContainer

func _process(delta) -> void:
	$Label.text = str(Global.coins)
