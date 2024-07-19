# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later
extends MarginContainer

signal back


const MIN:int = 100000
const MAX:int = 999999
const FACTOR:int = 10000 # MAX + 1 / FACTOR = aproximation amount of codes
const DIGITS:int = 6

const DAY:int = 86400

onready var paste_button:Button = $VBoxContainer/PasteContainer/Paste
onready var code_line:LineEdit = $VBoxContainer/CopyContainer/Code
onready var enter_code_line:LineEdit = $VBoxContainer/PasteContainer/EnterCode
onready var instructions:RichTextLabel = $VBoxContainer/InstructionsContainer/Instructions


var random_seed:String = "such4secret9seed"

func _ready() -> void:
	generate_codes()
	
	code_line.text = Global.own_code
	
	instructions.text = tr("HELP_INSTRUCTIONS")
	
	

func _on_Copy_pressed() -> void:
	AudioMachine.click()
	OS.clipboard = Global.own_code


func _on_Verify_pressed() -> void:
	AudioMachine.click()
	verify()
	
func verify() -> void:
	# parse code
	var verify_code:String = enter_code_line.text
	verify_code = verify_code.replace(" ", "")
	# check if valid
	if verify_code.length() == DIGITS and verify_code.is_valid_integer() and int(verify_code) in Global.codes:
		# unlock next locked level, if possible
		if unlock_last_level():
			Global.codes.erase(int(verify_code))
			Global.save_data()
			get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))
		else:
			print("NO LEVEL TO UNLOCK")
	else:
		print("FAILLLL")


func unlock_last_level() -> bool:
	var last_level:int = Global.level_stars.find(-1, 0)
	if last_level < 0 or last_level > Global.LEVELS:
		return false
	Global.level_stars[last_level] = 0
	Global.current_level = last_level + 1
	return true


func generate_codes() -> void:
	var current_seed:int = hash(random_seed) + OS.get_unix_time() / DAY
	if Global.generator_seed != current_seed:
		# generate new seed
		Global.generator_seed = current_seed
		var generator:RandomNumberGenerator = RandomNumberGenerator.new()
		generator.seed = Global.generator_seed
		# generate new codes
		Global.codes = []
		for code in range(MIN, MAX):
			if generator.randi() % FACTOR == 0:
				Global.codes.append(code)
		# assign own code
		var random_index:int = randi() % Global.codes.size()
		var own_code:int = Global.codes[random_index]
		Global.own_code = str(own_code).insert(3, " ")
		# disable own code
		Global.codes.erase(own_code)
	
		Global.save_data()


func _on_EnterCode_text_changed(new_text:String) -> void:
	if new_text.length() == DIGITS:
		verify()


func _on_Paste_pressed() -> void:
	AudioMachine.click()
	enter_code_line.text = OS.clipboard
	verify()

func _on_Video_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ")


func _on_Back_pressed() -> void:
	AudioMachine.click()
	emit_signal("back")
	
