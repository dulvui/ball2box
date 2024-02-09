# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later
extends Control

signal success
signal back


const MIN:int = 100000
const MAX:int = 999999
const FACTOR:int = 1000
const DIGITS:int = 6

const DAY:int = 86400

onready var paste_button:Button = $VBoxContainer/PasteContainer/Paste
onready var code_line:LineEdit = $VBoxContainer/CopyContainer/Code
onready var enter_code_line:LineEdit = $VBoxContainer/PasteContainer/EnterCode
onready var instructions:RichTextLabel = $VBoxContainer/PanelContainer/Instructions

var codes:Dictionary = {}
var code:String = "921 901"
var random_seed:String = "such4secret9seed"

func _ready() -> void:
	generate_codes()
	
	var random_index:int = randi() % codes.keys().size()
	codes.keys()[random_index] = false
	
	code = str(codes.keys()[random_index])
	print(codes.keys()[-1])
	
	code_line.text = code
	
	instructions.text = tr("HELP_INSTRUCTIONS")
	


func _on_Copy_pressed() -> void:
	AudioMachine.click()
	OS.clipboard = code


func _on_Verify_pressed() -> void:
	AudioMachine.click()
	verify()
	
func verify() -> void:
	var verify_code:String = enter_code_line.text.replace(" ", "")
	if verify_code.length() == DIGITS and verify_code.is_valid_integer() and verify_code in codes and codes[verify_code]:
		print("SUCCESSS")
		codes[verify_code] = false
		emit_signal("success")
	else:
		print("FAILLLL")


func _on_Back_pressed() -> void:
	AudioMachine.click()
	emit_signal("back")


func generate_codes() -> void:
	var generator:RandomNumberGenerator = RandomNumberGenerator.new()
	
	var time_stamp:int = OS.get_unix_time() / DAY
	generator.seed = hash(random_seed) + OS.get_unix_time() / DAY
	
	print("seed: " + str(generator.seed))
	
	for i in range(MIN, MAX):
		if generator.randi() % FACTOR == 0:
			codes[str(i)] = true
	print(codes.keys().size())


func _on_EnterCode_text_changed(new_text:String) -> void:
	if new_text.length() == DIGITS:
		verify()


func _on_Paste_pressed() -> void:
	AudioMachine.click()
	enter_code_line.text = OS.clipboard
