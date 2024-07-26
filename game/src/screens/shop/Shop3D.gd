# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node3D

var ball

func _ready() -> void:
	ball = BallMachine.get_selected()
	add_child(ball)

func next() -> void:
	ball.next()
	var new_ball = BallMachine.next()
	add_child(new_ball)
	new_ball.fade_in()
	ball = new_ball
	
func prev() -> void:
	ball.prev()
	var new_ball = BallMachine.prev()
	add_child(new_ball)
	new_ball.fade_in()
	ball = new_ball
	
func fade_in() -> void:
	ball.fade_in()
	
func menu() -> void:
	await get_tree().create_timer(0.2).timeout # its ugly whitout
	ball.fade_out()
