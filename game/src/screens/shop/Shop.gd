# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

signal next
signal prev
signal back
signal select

onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_set_select_label()

func _on_Next_pressed() -> void:
	emit_signal("next")
	_set_select_label()
	AudioMachine.click()


func _on_Prev_pressed() -> void:
	emit_signal("prev")
	_set_select_label()
	AudioMachine.click()


func set_values(ball:RigidBody) -> void:
	var mass_tween:Tween = Tween.new()
	add_child(mass_tween)
	mass_tween.interpolate_property($Mass, "value", $Mass.value, ball.mass, 0.4, Tween.EASE_IN, Tween.EASE_OUT)
	mass_tween.start()
	
	var bounce_tween:Tween = Tween.new()
	add_child(bounce_tween)
	bounce_tween.interpolate_property($Bounce, "value", $Bounce.value, ball.bounce, 0.4, Tween.EASE_IN, Tween.EASE_OUT)
	bounce_tween.start()
	
	
func _on_Back_pressed() -> void:
	AudioMachine.click()
	emit_signal("back")
	


func _on_Select_pressed() -> void:
	AudioMachine.play_click()
	var ball = BallMachine.get_current_ball_info()
	if Global.unlock_ball():
		BallMachine.select()
		_set_select_label()
	# special cases like follow, more games etc...
	elif ball["price"] is String:
		$Select.text = "SELECT"
		if ball["price"] == tr("FOLLOW"):
			OS.shell_open("https://mastodon.social/@dulvui")
		
		elif ball["price"] == tr("MORE_GAMES"):
			if OS.get_name() == "iOS":
				OS.shell_open("https://appstore.com/simondalvai")
			elif Global.FDROID or OS.get_name() == "HTML5":
				OS.shell_open("https://simondalvai.org/games")
			else:
				OS.shell_open("https://play.google.com/store/apps/dev?id=7836644900810357474&hl=en")
	else:
		$Select.text = str(ball["price"])
	
	emit_signal("select")
		

func _set_select_label() -> void:
	var ball = BallMachine.get_current_ball_info()
	if Global.unlocked_balls.has(ball["id"]):
		if BallMachine.current_ball_is_selected():
			$Select.text = "SELECTED"
		else:
			$Select.text = "SELECT"
		$Star.hide()
		
	else:
		if ball["price"] is String:
			$Select.text = str(ball["price"])
			$Star.hide()
		else:
			$Select.text = str(ball["price"])
			$Star.show()
			
	var ball_instance = ball["real"].instance()
	set_values(ball_instance)
