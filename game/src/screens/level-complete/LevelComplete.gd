# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

signal replay
signal menu
signal levels
signal help


var stars:int = 1

# to unlock next level without clicking on next level
# so when user closes game after level completes,
# the next level will appear when opening again
var first_time_complete:bool = false

func add_star() -> void:
	stars += 1
	if stars == 2:
		$VBoxContainer/Stars/Star2.self_modulate = Color("#fce527")
	if stars == 3:
		$VBoxContainer/Stars/Star3.self_modulate = Color("#fce527")
		
func reset_stars() -> void:
	stars = 1
	$VBoxContainer/Stars/Star2.self_modulate = Color("#fbf4be")
	$VBoxContainer/Stars/Star3.self_modulate = Color("#fbf4be")

	

func _on_Replay_pressed() -> void:
	AudioMachine.play_click()
	
	# remove automated level increase on replay
	if first_time_complete:
		Global.current_level -= 1
		first_time_complete = false
		
	emit_signal("replay")
	get_tree().paused = false
	hide()
#	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))


func _on_NextLevel_pressed() -> void:
	AudioMachine.click()
	if not first_time_complete:
		Global.current_level += 1
	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))

func game_over() -> void:
	$VBoxContainer/Level.text = str(Global.current_level)
	Global.set_level_stars(stars)
	
	if Global.unlock_next_level():
		Global.current_level += 1
		first_time_complete = true
	
	if Global.current_level > Global.LEVELS:
		$VBoxContainer/Buttons/NextLevel.hide()
	
	get_tree().paused = true


func _on_Menu_pressed() -> void:
	AudioMachine.click()
	if first_time_complete:
		Global.current_level -= 1
	emit_signal("menu")
	hide()


func _on_Levels_pressed() -> void:
	AudioMachine.click()
	emit_signal("levels")


func _on_Help_pressed() -> void:
	AudioMachine.click()
	emit_signal("help")

