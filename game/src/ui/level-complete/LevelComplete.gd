extends Control

signal replay
signal menu

var stars = 1

onready var animation_player = $AnimationPlayer

func add_star():
	stars += 1
	if stars == 2:
		$Star2.self_modulate = Color("#fce527")
	if stars == 3:
		$Star3.self_modulate = Color("#fce527")
		
func reset_stars():
	stars = 1
	$Star2.self_modulate = Color("#fbf4be")
	$Star3.self_modulate = Color("#fbf4be")

	

func _on_Replay_pressed():
	AudioMachine.play_click()
	emit_signal("replay")
	reset_stars()
	get_tree().paused = false
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	hide()
#	AdMob.destroy_banner()
#	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))


func _on_NextLevel_pressed():
	AudioMachine.click()
	if Global.current_level < Global.LEVELS :
		Global.current_level = Global.current_level+1
		get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))
#		AdMob.destroy_banner()

func _on_LevelComplete_visibility_changed():
	if visible:
		Global.unlock_next_level()
		Global.set_level_stars(stars)
		get_tree().paused = true
		$Level.text = str(Global.current_level)
		animation_player.play("FadeIn")


func _on_Menu_pressed():
	AudioMachine.click()
	emit_signal("menu")
	animation_player.play("FadeOut")
	yield(animation_player,"animation_finished")
	hide()
