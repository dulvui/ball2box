# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

onready var hand:Spatial = $Hand
onready var arrow:Spatial = $Arrow


func init() -> void:
	if Global.tutorial_tap_done:
		print("tutorial completed")
		queue_free()
		return
	
	# hsow arrow only in Level 1
	if Global.current_level > 1:
		arrow.queue_free()
	else:
		arrow.size()
	
	if not Global.tutorial_swipe_done:
		hand.swipe()
		
func fade_out() -> void:
	hand.fade_out()
	if has_node("Arrow"):
		arrow.fade_out()
		
func ball_shoot():
	Global.tutorial_swipe_done = true
	hand.tap()
	
func ball_reset():
	Global.tutorial_tap_done = true
	hand.fade_out()
