extends Control

signal shop

onready var animation_player:AnimationPlayer = $AnimationPlayer
var level_button:PackedScene = preload("res://src/screens/menu/level-button/LevelButton.tscn")

var current_page:int = 0

func _ready() -> void:
	$Menu/Buttons/Settings/Music/MusicButton.pressed = Global.music
	$Menu/Buttons/Settings/Sfx/SfxButton.pressed = Global.sfx
	current_page = Global.current_level/15
	_set_up_buttons()


func _process(delta:float) -> void:
	$Menu/Level.text = str(Global.current_level)

func _set_up_buttons() -> void:
	for b in $LevelSelect/Levels.get_children():
		b.queue_free()
	
	if current_page == 0:
		for i in range(1,16):
			var button:Control = level_button.instance()
			button.set_level(i)
			$LevelSelect/Levels.add_child(button)
	else:
		if current_page == (Global.LEVELS/15):
			current_page -= 1
		for i in range(current_page * 15 + 1,(current_page + 1) * 15 + 1):
			var button:Control = level_button.instance()
			button.set_level(i)
			$LevelSelect/Levels.add_child(button)
	
func _on_Play_pressed() -> void:
	AudioMachine.play_click()
	get_tree().paused = false
	animation_player.play("FadeOut")


func _on_Sfx_pressed() -> void:
	AudioMachine.click()
	animation_player.play("Sfx")
	Global.toggle_sfx()

func _on_Music_pressed() -> void:
	AudioMachine.click()
	animation_player.play("Music")
	Global.toggle_music()
	

func _on_InfoButton_pressed() -> void:
	AudioMachine.click()
	animation_player.play("InfoFadeIn")

func _on_Info_back() -> void:
	AudioMachine.click()
	animation_player.play("InfoFadeOut")

func _on_Levels_pressed() -> void:
	AudioMachine.click()
	_set_up_buttons()
	animation_player.play("LevelFadeIn")

func _on_Shop_pressed() -> void:
	AudioMachine.click()
	emit_signal("shop")
	
	
func _on_Back_pressed() -> void:
	animation_player.play("LevelFadeOut")
	

func _on_Prev_pressed() -> void:
	current_page -= 1
	if current_page < 0:
		current_page = (Global.LEVELS/15) -1
	animation_player.play("LevelOnlyFadeOut")
	yield(animation_player,"animation_finished")
	_set_up_buttons()
	animation_player.play("LevelOnlyFadeIn")


func _on_Next_pressed() -> void:
	animation_player.play()
	current_page += 1
	if current_page > (Global.LEVELS/15) -1:
		current_page = 0
	animation_player.play("LevelOnlyFadeOut")
	yield(animation_player,"animation_finished")
	_set_up_buttons()
	animation_player.play("LevelOnlyFadeIn")



func _on_SimonDalvai_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://simondalvai.com")
