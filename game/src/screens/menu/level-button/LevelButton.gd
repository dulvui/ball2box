# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

var level:int = 1
var stars:int

func set_level(l:int) -> void:
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
	

func _on_Button_pressed() -> void:
	if stars > -1:
		AudioMachine.play_click()
		Global.current_level = level
		get_tree().change_scene("res://src/levels/Level%s.tscn"%level)
