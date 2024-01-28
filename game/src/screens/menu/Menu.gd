# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

signal shop

onready var animation_player:AnimationPlayer = $AnimationPlayer
var level_button:PackedScene = preload("res://src/screens/menu/level-button/LevelButton.tscn")

var current_page:int = 0

func _ready() -> void:
	$Menu/Buttons/Settings/Music/MusicButton.pressed = Global.music
	$Menu/Buttons/Settings/Sfx/SfxButton.pressed = Global.sfx
	current_page = Global.current_level/15
	$Menu/Buttons/Level/Level.text = "  level " + str(Global.current_level) + "  "
	_set_up_buttons()

func show_levels():
	AudioMachine.click()
	_set_up_buttons()
	animation_player.play("LevelFadeIn")

func _set_up_buttons() -> void:
	for b in $LevelSelect/Levels.get_children():
		b.queue_free()
	
	if current_page == 0:
		for i in range(1,16):
			var button:Control = level_button.instance()
			button.set_level(i)
			$LevelSelect/Levels.add_child(button)
	else:
		if current_page == (Global.LEVELS/15):
			current_page -= 1
		for i in range(current_page * 15 + 1,(current_page + 1) * 15 + 1):
			var button:Control = level_button.instance()
			button.set_level(i)
			$LevelSelect/Levels.add_child(button)
	
func _on_Play_pressed() -> void:
	AudioMachine.click()
	emit_signal("shop")

func play() -> void:
	get_tree().paused = false
	animation_player.play("FadeOut")

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


func _on_Shop_pressed() -> void:
	AudioMachine.click()
	emit_signal("shop")
	
	
func _on_Back_pressed() -> void:
	animation_player.play("LevelFadeOut")
	

func _on_Prev_pressed() -> void:
	current_page -= 1
	if current_page < 0:
		current_page = (Global.LEVELS/15) -1
	animation_player.play("LevelOnlyFadeOut")
	yield(animation_player,"animation_finished")
	_set_up_buttons()
	animation_player.play("LevelOnlyFadeIn")


func _on_Next_pressed() -> void:
	animation_player.play()
	current_page += 1
	if current_page > (Global.LEVELS/15) -1:
		current_page = 0
	animation_player.play("LevelOnlyFadeOut")
	yield(animation_player,"animation_finished")
	_set_up_buttons()
	animation_player.play("LevelOnlyFadeIn")


func _on_SimonDalvai_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://simondalvai.org")


func _on_GithubButton_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://github.com/dulvui/ball2box")


func _on_Level_pressed() -> void:
	AudioMachine.click()
	show_levels()


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
