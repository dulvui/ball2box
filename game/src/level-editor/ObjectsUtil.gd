# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later
extends Node

const OBJECTS_PATH: String = "res://src/actors/objects/"

var objects: Array = []
var selected: int = 0

func _ready() -> void:
	var objects_paths: Array = _get_object_paths()
	objects = _load_objects(objects_paths)


func get_all_objects() -> Array:
	var list: Array = []
	for object in objects:
		list.append(object.instance())
	return list


func get_object(index: int = selected) -> Spatial:
	return objects[index].instance()


func get_object_by_id(id: String) -> Spatial:
	for object in objects:
		if object.filename == id:
			return object
	return objects[0].instance()


func next() -> Spatial:
	selected += 1
	if selected > objects.size() - 1:
		selected = 0
	return get_object()


func prev() -> Spatial:
	selected -= 1
	if selected < 0:
		selected = objects.size() - 1
	return get_object()


func _load_objects(objects_paths: Array) -> Array:
	var list: Array = []
	var index: int = 0
	for path in objects_paths:
		var object_scene: PackedScene = load(path)
		list.append(object_scene)
		index += 1
	
	return list


func _get_object_paths() -> Array:
	var list: Array = []
	var dir: Directory = Directory.new()
	if dir.open(OBJECTS_PATH) == OK:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "." and file_name != "..":
				var sub_dir: Directory = Directory.new()
				sub_dir.open(OBJECTS_PATH + file_name)
				sub_dir.list_dir_begin()
				var sub_dir_file_name: String = sub_dir.get_next()
				while sub_dir_file_name != "":
					if ".tscn" in sub_dir_file_name and sub_dir_file_name != "BaseObject.tscn":
						list.append(OBJECTS_PATH + file_name + "/" + sub_dir_file_name)
					sub_dir_file_name = sub_dir.get_next()
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access objects path.")
	return list

