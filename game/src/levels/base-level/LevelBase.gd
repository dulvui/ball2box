extends Spatial

const moveTrans = Tween.TRANS_LINEAR
const moveEase = Tween.EASE_OUT

onready var camera:Camera = $Base/Camera
onready var tween:Tween = $Tween

var ball




func _ready():
	AudioMachine.reset()
	if Global.just_opened:
		Global.just_opened = false
		
		if Global.tutorial_done:
			get_tree().paused = true
			$UI/Menu.animation_player.play("FirstFadeIn")
			$AnimationPlayer.play("FadeIn")
			$AnimationPlayer.play("TopbarFadeIn")
			$UI/Tutorial.queue_free()
		else:
			get_tree().paused = false
			$Bin.hide()
			$UI/Tutorial.visible = true
			$UI/Tutorial.start()
	else:
		get_tree().paused = false
		$AnimationPlayer.play("Idle")
	fade_in_objects()
		
	ball = $Ball

	var pos = ball.initial_position
	ball.queue_free()
	ball = BallMachine.get_real()
	ball.initial_position = pos
	ball.translation = pos
	add_child(ball)
		
	
	ball.connect("reset_ball",self,"_on_Ball_reset_ball")
	$Star1.connect("star_hit",self,"on_star1_hit")
	$Star2.connect("star_hit",self,"on_star2_hit")


func fade_in_objects():
	for object in get_tree().get_nodes_in_group("objects"):
		object.fade_in()
		
func fade_in_pop_objects():
	for object in get_tree().get_nodes_in_group("pop-objects"):
		object.fade_in()
	
func on_star1_hit():
	$UI/LevelComplete.add_star()
	AudioMachine.hit(false)
#	_camera_shake()
	
func on_star2_hit():
	$UI/LevelComplete.add_star()
	AudioMachine.hit(false)
#	_camera_shake()

	

func _on_Bin_win():
	AudioMachine.hit(true)
	$UI/LevelComplete.show()

func on_star_hit():
	$UI/LevelComplete.add_star()


func _on_Menu_shop():
	$UI/Menu.animation_player.play("FadeOut")
	$AnimationPlayer.play("GoToShop")
	yield($UI/Menu.animation_player,"animation_finished")
	$UI/Menu.hide()
	$UI/Shop.show()
	$UI/Shop.animation_player.play("FadeIn")
	$Base/Shop3D.shop()
	


func _on_Shop_back():
	$UI/Shop.animation_player.play("FadeOut")
	yield($UI/Shop.animation_player,"animation_finished")
	$UI/Shop.hide()
	
	$UI/Menu.show()
	$UI/Menu.animation_player.play("FadeIn")
	$Base/Shop3D.menu()
	$AnimationPlayer.play("GoToMenu")
	
	# reset level after coming back from shop
	_on_Ball_reset_ball()
	ball.reset()


func _on_Shop_select():
	if Global.unlock_ball():
		$Base/Shop3D.select()
		
		$UI/Shop.animation_player.play("FadeOut")
		yield($UI/Shop.animation_player,"animation_finished")
		$UI/Shop.hide()
		
		$UI/Menu.show()
		$UI/Menu.animation_player.play("FadeIn")
		$Base/Shop3D.menu()
		$AnimationPlayer.play("GoToMenu")
		
		var pos = ball.initial_position
		ball.queue_free()
		ball = BallMachine.get_real()
		ball.initial_position = pos
		ball.translation = pos
		add_child(ball)
			
		ball.connect("reset_ball",self,"_on_Ball_reset_ball")
		
		# reset level after coming back from shop
		_on_Ball_reset_ball()
		ball.reset()
	


func _on_Shop_prev():
	$Base/Shop3D.prev()


func _on_Shop_next():
	$Base/Shop3D.next()


func _on_LevelComplete_replay():
	ball.reset_no_signal()
	$UI/LevelComplete.reset_stars()
	AudioMachine.reset()
	fade_in_pop_objects()
	$Star1.show_star()
	$Star2.show_star()

func _camera_shake():
	var start_position = camera.translation
	
	var shakes:int = (randi()%3) + 1
	for i in shakes:
		var random_vector = camera.translation - Vector3(rand_range(-1,1),rand_range(-1,1), rand_range(-1,1))
		tween.interpolate_property(camera, "translation",camera.translation, random_vector, 0.1, moveTrans, moveEase)
		tween.start()
		yield(tween, "tween_all_completed")
	
	tween.interpolate_property(camera, "translation", camera.translation, start_position, 0.2, moveTrans, moveEase)
	tween.start()


func _on_Pause_pressed():
	AudioMachine.click()
	print("pause")
	if not get_tree().paused:
		print("pause pass")
		$UI/Menu.show()
		$UI/Menu.animation_player.play("FadeIn")
		get_tree().paused = true

func _on_Ball_reset_ball():
	$UI/LevelComplete.reset_stars()
	AudioMachine.reset()
	$Star1.show_star()
	$Star2.show_star()
	
	fade_in_pop_objects()
		
	Global.save_data()


func _on_LevelComplete_menu():
	ball.reset()
	$UI/Menu.animation_player.play("FadeIn")
	$UI/LevelComplete.reset_stars()
	AudioMachine.reset()
	$Star1.show_star()
	$Star2.show_star()
	

func _on_Tutorial_done():
	$Bin.show()
	Global.tutorial_done = true
	Global.save_data()
