extends Control

var level = 1
var stars

func set_level(l):
	level = l
	$MarginContainer/Info/Label.text = str(level)
	stars = Global.level_stars[level- 1]
	
	if stars == -1:
		$MarginContainer/Info/Stars/Star1.modulate = Color("#000000")
		$MarginContainer/Info/Stars/Star2.modulate = Color("#000000")
		$MarginContainer/Info/Stars/Star3.modulate = Color("#000000")
		$MarginContainer/Info/Label.modulate = Color("#000000")
	
	if stars >= 1:
		$MarginContainer/Info/Stars/Star1.modulate = Color("#fce527")
	if stars >= 2:
		$MarginContainer/Info/Stars/Star2.modulate = Color("#fce527")
	if stars == 3:
		$MarginContainer/Info/Stars/Star3.modulate = Color("#fce527")
	

func _on_Button_pressed():
	if stars > -1:
		AudioMachine.play_click()
		Global.current_level = level
		get_tree().change_scene("res://src/levels/Level%s.tscn"%level)
