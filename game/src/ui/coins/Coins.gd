# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.com>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends HBoxContainer

func _process(delta) -> void:
	$Label.text = str(Global.coins)
