# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

signal replay
signal menu
signal levels

var stars:int = 1

# to unlock next level without clicking on next level
# so when user closes game after level completes,
# the next level will appear when opening again
var first_time_complete:bool = false

onready var animation_player = $AnimationPlayer

func add_star() -> void:
	stars += 1
	if stars == 2:
		$Star2.self_modulate = Color("#fce527")
	if stars == 3:
		$Star3.self_modulate = Color("#fce527")
		
func reset_stars() -> void:
	stars = 1
	$Star2.self_modulate = Color("#fbf4be")
	$Star3.self_modulate = Color("#fbf4be")

	

func _on_Replay_pressed() -> void:
	AudioMachine.play_click()
	
	# remove automated level increase on replay
	if first_time_complete:
		Global.current_level = Global.current_level - 1
		first_time_complete = false
		
	emit_signal("replay")
	get_tree().paused = false
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	hide()
#	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))


func _on_NextLevel_pressed() -> void:
	AudioMachine.click()
	if not first_time_complete:
		Global.current_level = Global.current_level + 1
	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))

func game_over() -> void:
	$Level.text = str(Global.current_level)
	Global.set_level_stars(stars)
	
	if Global.unlock_next_level():
		Global.current_level = Global.current_level + 1
		first_time_complete = true
	
	if Global.current_level > Global.LEVELS:
		$Buttons/NextLevel.hide()
	
	get_tree().paused = true
	animation_player.play("FadeIn")


func _on_Menu_pressed() -> void:
	AudioMachine.click()
	emit_signal("menu")
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	hide()


func _on_Levels_pressed() -> void:
	AudioMachine.click()
	emit_signal("levels")
