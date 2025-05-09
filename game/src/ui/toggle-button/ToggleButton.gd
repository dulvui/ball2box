# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Button

@export var normal_texture:Texture2D
@export var pressed_texture:Texture2D

func _ready() -> void:
	icon = normal_texture


func _on_ToggleButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		icon = pressed_texture
	else:
		icon = normal_texture

