# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

const moveTrans:int = Tween.TRANS_LINEAR
const moveEase:int = Tween.EASE_OUT

onready var camera:Camera = $Base/Camera
onready var tween:Tween = $Tween
onready var level_complete:Control = $UI/LevelComplete
onready var portals:Spatial = $Portals/PortalConnector


var ball:RigidBody

func _ready() -> void:
	AudioMachine.reset()
	
	$Tutorial.init()
	
	if Global.just_opened:
		Global.just_opened = false
		
		if Global.tutorial_swipe_done:
			get_tree().paused = true
			$UI/Menu.animation_player.play("FirstFadeIn")
			$AnimationPlayer.play("FadeIn")
			$AnimationPlayer.play("TopbarFadeIn")
		else:
			get_tree().paused = false
	else:
		get_tree().paused = false
	fade_in_objects()
		
	ball = $Ball

	var pos:Vector3 = ball.initial_position
	ball.queue_free()
	ball = BallMachine.get_real()
	ball.initial_position = pos
	ball.translation = pos
	add_child(ball)
		
	
	_connect_ball_signals()
	$Star1.connect("star_hit",self,"on_star1_hit")
	$Star2.connect("star_hit",self,"on_star2_hit")

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
		$Tutorial.fade_out()
	level_complete.game_over()
	level_complete.show()
	AudioMachine.hit(true)
	Global.save_data()
	

func _on_Menu_shop() -> void:
	$UI/Menu.animation_player.play("FadeOut")
	$AnimationPlayer.play("GoToShop")
	yield($UI/Menu.animation_player,"animation_finished")
	$UI/Menu.hide()
	$UI/Shop.show()
	$UI/Shop.animation_player.play("FadeIn")
	$Base/Shop3D.shop()
	


func _on_Shop_back() -> void:
	$UI/Shop.animation_player.play("FadeOut")
	yield($UI/Shop.animation_player,"animation_finished")
	$UI/Shop.hide()
	
	$UI/Menu.show()
	$UI/Menu.animation_player.play("FadeIn")
	$Base/Shop3D.menu()
	$AnimationPlayer.play("GoToMenu")


func _on_Shop_select() -> void:

	# don't go to menu directly https://github.com/dulvui/ball2box/issues/9#issuecomment-1572743713
#	$UI/Shop.animation_player.play("FadeOut")
#	yield($UI/Shop.animation_player,"animation_finished")
#	$UI/Shop.hide()
#
#	$UI/Menu.show()
#	$UI/Menu.animation_player.play("FadeIn")
#	$Base/Shop3D.menu()
#	$AnimationPlayer.play("GoToMenu")
	
	var pos = ball.initial_position
	ball.queue_free()
	ball = BallMachine.get_real()
	ball.initial_position = pos
	ball.translation = pos
	add_child(ball)
		
	# reset level after coming back from shop
	_connect_ball_signals()
	
	
	$UI/Shop.animation_player.play("FadeOut")
	yield($UI/Shop.animation_player,"animation_finished")
	$UI/Shop.hide()
	$AnimationPlayer.play("GoToMenu")
	$UI/Menu.play()
	


func _on_Shop_prev() -> void:
	$Base/Shop3D.prev()


func _on_Shop_next() -> void:
	$Base/Shop3D.next()


func _on_LevelComplete_replay() -> void:
	ball.reset_no_signal()
	level_complete.reset_stars()
	AudioMachine.reset()
	fade_in_pop_objects()
	$Star1.show_star()
	$Star2.show_star()

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
		$UI/Menu.show()
		$UI/Menu.animation_player.play("FadeIn")
		get_tree().paused = true

func _on_LevelComplete_menu() -> void:
	ball.reset()
	$UI/Menu.show()
	$UI/Menu.animation_player.play("FadeIn")
	level_complete.reset_stars()
	AudioMachine.reset()
	$Star1.show_star()
	$Star2.show_star()
	portals.reset()



func _on_Ball_reset() -> void:
	portals.reset()
	
	level_complete.reset_stars()
	AudioMachine.reset()
	
	$Star1.show_star()
	$Star2.show_star()
	$Star1.is_hitable = false
	$Star2.is_hitable = false
	
	fade_in_pop_objects()
		
	Global.save_data()
	if has_node("Tutorial"):
		$Tutorial.ball_reset()


func _on_Ball_shoot() -> void:
	$Star1.is_hitable = true
	$Star2.is_hitable = true
	
	if has_node("Tutorial"):
		$Tutorial.ball_shoot()


func _on_LevelComplete_levels():
	level_complete.hide()
	ball.reset()
	$UI/Menu.show_levels()
	level_complete.reset_stars()
	AudioMachine.reset()
	$Star1.show_star()
	$Star2.show_star()

func _connect_ball_signals():
	ball.connect("reset",self,"_on_Ball_reset")
	ball.connect("shoot",self,"_on_Ball_shoot")
