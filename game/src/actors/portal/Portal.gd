# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node3D

signal ball_entered(ball)

func _on_Area_body_entered(body):
	print("body entered")
	if body.is_in_group("ball"):
		print("ball entered")
		emit_signal("ball_entered", body)

