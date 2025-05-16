# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends VBoxContainer

signal levels

onready var next_level_button: Button = $Buttons/NextLevel
onready var prev_level_button: Button = $Buttons/PrevLevel

onready var star1: TextureRect = $Stars/Star1
onready var star2: TextureRect = $Stars/Star2
onready var star3: TextureRect = $Stars/Star3


func _ready() -> void:
	update_level()


func update_level() -> void:
	$Buttons/LevelButton.text = "level " + str(Global.current_level)
	var stars:int = Global.level_stars[Global.current_level - 1]

	# disable prev/next level button for last and first level
	next_level_button.disabled = Global.current_level == Global.LEVELS
	prev_level_button.disabled = Global.current_level == 1
	
	if stars >= 1:
		star1.modulate = Color("#fce527")
	if stars >= 2:
		star2.modulate = Color("#fce527")
	if stars >= 3: # on some devices wh old versions, > 3 stars could happen
		star3.modulate = Color("#fce527")


func _on_PrevLevel_pressed() -> void:
	AudioMachine.click()
	if Global.current_level > 1:
		Global.current_level -= 1
		Global.show_main = true
		get_tree().change_scene("res://src/levels/Level%s.tscn"%(Global.current_level))


func _on_NextLevel_pressed() -> void:
	AudioMachine.click()
	if Global.current_level < Global.LEVELS and Global.level_stars[Global.current_level] >= 0:
		Global.current_level += 1
		Global.show_main = true
		get_tree().change_scene("res://src/levels/Level%s.tscn"%(Global.current_level))


func _on_LevelButton_pressed() -> void:
	AudioMachine.click()
	emit_signal("levels")


func _on_LevelControl_visibility_changed() -> void:
	update_level()

