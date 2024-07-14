# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node


const OBJECTS_PATH: String = "res://src/actors/objects/"

var objects_paths: Array = []

func _ready() -> void:
	objects_paths = load_object_paths()


func load_object_paths() -> Array:
	var list: Array = []
	var dir: Directory = Directory.new()
	if dir.open(OBJECTS_PATH) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "." and file_name != "..":
#				print("Found directory: " + file_name)
				var sub_dir: Directory = Directory.new()
				sub_dir.open(OBJECTS_PATH + file_name)
				sub_dir.list_dir_begin()
				var sub_dir_file_name = sub_dir.get_next()
				# .tscn is after .gd
				while sub_dir_file_name != "":
					if ".tscn" in sub_dir_file_name:
						print("Found object: " + sub_dir_file_name)
						list.append(OBJECTS_PATH + file_name + "/" + sub_dir_file_name)
					sub_dir_file_name = sub_dir.get_next()
#			else:
#				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access objects path.")
	print(list.size())
	print(list)
	return list

