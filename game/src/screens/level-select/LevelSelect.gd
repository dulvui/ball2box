# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends MarginContainer

signal select
signal back

const level_button:PackedScene = preload("res://src/screens/level-select/level-button/LevelButton.tscn")

onready var level_grid:GridContainer = $VBoxContainer/Levels

var current_page:int = 0


func _ready():
	current_page = Global.current_level/15
	_set_up_buttons()

func _set_up_buttons() -> void:
	for b in level_grid.get_children():
		b.queue_free()
	
	if current_page == 0:
		for i in range(1,16):
			var button:Control = level_button.instance()
			button.set_level(i)
			button.connect("select", self, "_on_level_select")
			level_grid.add_child(button)
	else:
		if current_page == (Global.LEVELS/15):
			current_page -= 1
		for i in range(current_page * 15 + 1,(current_page + 1) * 15 + 1):
			var button:Control = level_button.instance()
			button.set_level(i)
			button.connect("select", self, "_on_level_select")
			level_grid.add_child(button)


func _on_level_select() -> void:
	emit_signal("select")


func _on_Prev_pressed() -> void:
	AudioMachine.click()
	current_page -= 1
	if current_page < 0:
		current_page = (Global.LEVELS/15) -1
	_set_up_buttons()


func _on_Next_pressed() -> void:
	AudioMachine.click()
	current_page += 1
	if current_page > (Global.LEVELS/15) -1:
		current_page = 0
	_set_up_buttons()


func _on_Back_pressed():
	AudioMachine.click()
	emit_signal("back")
