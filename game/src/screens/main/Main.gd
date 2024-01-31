# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

signal play
signal levels
signal info

onready var animation_player:AnimationPlayer = $AnimationPlayer
onready var star1:TextureRect = $Buttons/Level/Stars/Star1
onready var star2:TextureRect = $Buttons/Level/Stars/Star2
onready var star3:TextureRect = $Buttons/Level/Stars/Star3


func _ready() -> void:
	$Buttons/Settings/Music/MusicButton.pressed = Global.music
	$Buttons/Settings/Sfx/SfxButton.pressed = Global.sfx
	$Buttons/Level/LevelControl/LevelButton.text = "level " + str(Global.current_level)
	
	var stars:int = Global.level_stars[Global.current_level - 1]
	
	if stars >= 1:
		star1.modulate = Color("#fce527")
	if stars >= 2:
		star2.modulate = Color("#fce527")
	if stars >= 3: # on some devices wh old versions, > 3 stars could happen
		star3.modulate = Color("#fce527")
	
func _on_Play_pressed() -> void:
	AudioMachine.click()
	emit_signal("play")

	
func _on_InfoButton_pressed() -> void:
	AudioMachine.click()
	emit_signal("info")

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
		Global.show_main = true
		get_tree().change_scene("res://src/levels/Level%s.tscn"%(Global.current_level))

func _on_NextLevel_pressed() -> void:
	AudioMachine.click()
	if Global.current_level + 1 < Global.LEVELS and Global.level_stars[Global.current_level] >= 0:
		Global.current_level += 1
		Global.show_main = true
		get_tree().change_scene("res://src/levels/Level%s.tscn"%(Global.current_level))


func _on_LevelButton_pressed() -> void:
	emit_signal("levels")


func _on_SfxButton_pressed() -> void:
	AudioMachine.click()
	Global.toggle_sfx()


func _on_MusicButton_pressed() -> void:
	AudioMachine.click()
	Global.toggle_music()
	
