# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends MarginContainer

signal play
signal levels
signal info
signal help

func _ready() -> void:
	$Buttons/Settings/MusicButton.pressed = Global.music
	$Buttons/Settings/SfxButton.pressed = Global.sfx
	$Buttons/Settings/FullScreenButton.visible = OS.get_name() != "Android" and OS.get_name() != "iOS"

	
func _on_Play_pressed() -> void:
	AudioMachine.click()
	emit_signal("play")

	
func _on_InfoButton_pressed() -> void:
	AudioMachine.click()
	emit_signal("info")

func _on_Info_back() -> void:
	AudioMachine.click()


func _on_SimonDalvai_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://simondalvai.org")


func _on_GithubButton_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://github.com/dulvui/ball2box")


func _on_SfxButton_pressed() -> void:
	AudioMachine.click()
	Global.toggle_sfx()


func _on_MusicButton_pressed() -> void:
	AudioMachine.click()
	Global.toggle_music()


func _on_FullScreenButton_pressed() -> void:
	AudioMachine.click()
	Global.toggle_full_screen()



func _on_Help_pressed() -> void:
	AudioMachine.click()
	emit_signal("help")


func _on_LevelControl_levels() -> void:
	emit_signal("levels")
