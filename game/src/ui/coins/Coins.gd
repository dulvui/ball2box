extends HBoxContainer

func _process(delta):
	$Label.text = str(Global.coins)
