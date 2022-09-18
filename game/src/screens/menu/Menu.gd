extends Control

signal shop

onready var animation_player = $AnimationPlayer
var level_button = preload("res://src/screens/menu/level-button/LevelButton.tscn")

var current_page = 0

func _ready():
	$Menu/Buttons/Settings/Music/MusicButton.pressed = Global.music
	$Menu/Buttons/Settings/Sfx/SfxButton.pressed = Global.sfx
	current_page = Global.current_level/15
	_set_up_buttons()


func _set_up_buttons():
	for b in $LevelSelect/Levels.get_children():
		b.queue_free()
	
	if current_page == 0:
		for i in range(1,16):
			var button = level_button.instance()
			button.set_level(i)
			$LevelSelect/Levels.add_child(button)
	else:
		if current_page == (Global.LEVELS/15):
			current_page -= 1
		for i in range(current_page * 15 + 1,(current_page + 1) * 15 + 1):
			var button = level_button.instance()
			button.set_level(i)
			$LevelSelect/Levels.add_child(button)

func _process(delta):
	$Menu/Level.text = str(Global.current_level)
	
func _on_Play_pressed():
	AudioMachine.play_click()
	get_tree().paused = false
	animation_player.play("FadeOut")


func _on_Sfx_pressed():
	AudioMachine.click()
	animation_player.play("Sfx")
	Global.toggle_sfx()

func _on_Music_pressed():
	AudioMachine.click()
	animation_player.play("Music")
	Global.toggle_music()



func _on_Levels_pressed():
	AudioMachine.click()
	_set_up_buttons()
	animation_player.play("LevelFadeIn")

func _on_Shop_pressed():
	AudioMachine.click()
	emit_signal("shop")
	
	
func _on_Back_pressed():
	animation_player.play("LevelFadeOut")
	

func _on_Prev_pressed():
	current_page -= 1
	if current_page < 0:
		current_page = (Global.LEVELS/15) -1
	animation_player.play("LevelOnlyFadeOut")
	yield(animation_player,"animation_finished")
	_set_up_buttons()
	animation_player.play("LevelOnlyFadeIn")


func _on_Next_pressed():
	animation_player.play()
	current_page += 1
	if current_page > (Global.LEVELS/15) -1:
		current_page = 0
	animation_player.play("LevelOnlyFadeOut")
	yield(animation_player,"animation_finished")
	_set_up_buttons()
	animation_player.play("LevelOnlyFadeIn")



func _on_SimonDalvai_pressed():
	AudioMachine.click()
	OS.shell_open("https://simondalvai.com")
