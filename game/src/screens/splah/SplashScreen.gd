# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

func _ready() -> void:
	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))
