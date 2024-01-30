# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

const moveTrans:int = Tween.TRANS_LINEAR
const moveEase:int = Tween.EASE_OUT

onready var camera:Camera = $Base/Camera
onready var tween:Tween = $Tween
onready var level_complete:Control = $UI/LevelComplete
onready var shop3D:Spatial = $Shop3D
onready var ball:Ball = $Ball
onready var star1:Spatial = $Star1
onready var star2:Spatial = $Star2
onready var tutorial:Spatial = $Tutorial
onready var animation_player:AnimationPlayer = $AnimationPlayer

onready var main:Control = $UI/Main
onready var levels:Control = $UI/LevelSelect
onready var shop:Control = $UI/Shop
onready var info:Control = $UI/Info


var portals:Spatial

func _ready() -> void:
	AudioMachine.reset()
	
	tutorial.init()
	
	if Global.show_main:
		Global.show_main = false

		if Global.tutorial_swipe_done:
			get_tree().paused = true
			main.show()
		else:
			get_tree().paused = false
			main.hide()
	else:
		get_tree().paused = false
		main.hide()
		

	fade_in_objects()
	
	_connect_ball_signals()
	star1.connect("star_hit",self,"on_star1_hit")
	star2.connect("star_hit",self,"on_star2_hit")
	
	# portals only exist in some levels
	portals = get_node_or_null("Portals/PortalConnector")


func fade_in_objects() -> void:
	for object in get_tree().get_nodes_in_group("objects"):
		object.fade_in()
		
func fade_in_pop_objects() -> void:
	for object in get_tree().get_nodes_in_group("pop-objects"):
		object.fade_in()
	
func on_star1_hit() -> void:
	level_complete.add_star()
	AudioMachine.hit(false)
#	_camera_shake()
	
func on_star2_hit() -> void:
	level_complete.add_star()
	AudioMachine.hit(false)
#	_camera_shake()


func _on_Bin_win() -> void:
	if has_node("Tutorial"):
		tutorial.fade_out()
	level_complete.game_over()
	level_complete.show()
	AudioMachine.hit(true)
	Global.save_data()
	

func _on_Shop_back() -> void:
	shop.hide()
	
	main.show()
	main.animation_player.play("FadeIn")
	shop3D.menu()
	animation_player.play("GoToMenu")


func _on_Shop_select() -> void:
	# menu animations
	shop.hide()
	animation_player.play("GoToMenu")
	
	# ball setup
	var pos:Transform = ball.initial_position
	print("shop transform " + str(pos))
	ball.queue_free()
	
	ball = BallMachine.get_real()
	add_child(ball)
	# assign initial_position after adding to node
	# otherwhise initial_position gets overwritten
	ball.initial_position = pos
	ball.teletransport_to_inital()
	_connect_ball_signals()
	
	get_tree().paused = false


func _on_Shop_prev() -> void:
	shop3D.prev()


func _on_Shop_next() -> void:
	shop3D.next()


func _on_LevelComplete_replay() -> void:
	ball.reset_position_no_signal()
	level_complete.reset_stars()
	AudioMachine.reset()
	fade_in_pop_objects()
	star1.show_star()
	star2.show_star()

func _camera_shake() -> void:
	var start_position:Vector3 = camera.translation
	
	var shakes:int = (randi()%3) + 1
	for i in shakes:
		var random_vector:Vector3 = camera.translation - Vector3(rand_range(-1,1),rand_range(-1,1), rand_range(-1,1))
		tween.interpolate_property(camera, "translation",camera.translation, random_vector, 0.1, moveTrans, moveEase)
		tween.start()
		yield(tween, "tween_all_completed")
	
	tween.interpolate_property(camera, "translation", camera.translation, start_position, 0.2, moveTrans, moveEase)
	tween.start()


func _on_Pause_pressed() -> void:
	AudioMachine.click()
	if not get_tree().paused:
		main.show()
		main.animation_player.play("FadeIn")
		get_tree().paused = true

func _on_LevelComplete_menu() -> void:
	ball.reset_position()
	main.show()
	main.animation_player.play("FadeIn")
	level_complete.reset_stars()
	AudioMachine.reset()
	star1.show_star()
	star2.show_star()
	
	if portals:
		portals.reset()



func _on_Ball_reset() -> void:
	if portals:
		portals.reset()
	
	level_complete.reset_stars()
	AudioMachine.reset()
	
	star1.show_star()
	star2.show_star()
	star1.is_hitable = false
	star2.is_hitable = false
	
	fade_in_pop_objects()
		
	Global.save_data()
	if has_node("Tutorial"):
		tutorial.ball_reset()


func _on_Ball_shoot() -> void:
	star1.is_hitable = true
	star2.is_hitable = true
	
	if has_node("Tutorial"):
		tutorial.ball_shoot()


func _on_LevelComplete_levels():
	level_complete.hide()
	ball.reset_position()
	level_complete.reset_stars()
	AudioMachine.reset()
	star1.show_star()
	star2.show_star()
	levels.show()

func _connect_ball_signals():
	if ball.is_connected("reset", self, "_on_Ball_reset"):
		ball.disconnect("reset",self,"_on_Ball_reset")
	if ball.is_connected("shoot",self,"_on_Ball_shoot"):
		ball.disconnect("shoot",self,"_on_Ball_shoot")
	
	ball.connect("reset",self,"_on_Ball_reset")
	ball.connect("shoot",self,"_on_Ball_shoot")


func _on_Main_play():
	AudioMachine.click()
#	get_tree().paused = false

	main.hide()
	animation_player.play("GoToShop")
	shop3D.fade_in()
	shop.show()


func _on_Main_levels():
	main.hide()
	levels.show()


func _on_LevelSelect_back():
	levels.hide()
	main.show()


func _on_Main_info():
	main.hide()
	info.show()


func _on_Info_back():
	info.hide()
	main.show()
