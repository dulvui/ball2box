# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

signal play
signal levels

onready var animation_player:AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	$Buttons/Settings/Music/MusicButton.pressed = Global.music
	$Buttons/Settings/Sfx/SfxButton.pressed = Global.sfx
	$Buttons/Level/LevelButton.text = "level " + str(Global.current_level)

	
func _on_Play_pressed() -> void:
	AudioMachine.click()
	emit_signal("play")

func _on_Sfx_pressed() -> void:
	AudioMachine.click()
	Global.toggle_sfx()

func _on_Music_pressed() -> void:
	AudioMachine.click()
	Global.toggle_music()
	

func _on_InfoButton_pressed() -> void:
	AudioMachine.click()
	animation_player.play("InfoFadeIn")

func _on_Info_back() -> void:
	AudioMachine.click()
	animation_player.play("InfoFadeOut")


func _on_SimonDalvai_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://simondalvai.org")


func _on_GithubButton_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://github.com/dulvui/ball2box")


func _on_PrevLevel_pressed() -> void:
	AudioMachine.click()
	if Global.current_level > 1:
		Global.current_level -= 1
		get_tree().change_scene("res://src/levels/Level%s.tscn"%(Global.current_level - 1))

func _on_NextLevel_pressed() -> void:
	AudioMachine.click()
	if Global.current_level + 1 < Global.LEVELS and Global.level_stars[Global.current_level] >= 0:
		Global.current_level += 1
		get_tree().change_scene("res://src/levels/Level%s.tscn"%(Global.current_level - 1))


func _on_LevelButton_pressed():
	emit_signal("levels")
