# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

onready var ball: RigidBody = $Ball
onready var objects: Spatial = $Objects

var objects_list: Array = []
var active_object: Spatial

func _ready() -> void:
	var object: Spatial = ObjectsUtil.get_object()
	_set_active(object)


func _on_Add_pressed():
	var object: Spatial = ObjectsUtil.get_object()
	objects_list.append(object)
	add_child(object)
	# TODO move a bit, replace with animation
	object.transform.origin = Vector3(0, 22, 0)
	if object.has_method("fade_in"):
		object.fade_in()
	print('add')
	print(objects_list.size())
	print(objects.get_child_count())
	
	print(export_as_base64())


func _on_Delete_pressed():
	pass # Replace with function body.


func _on_Next_pressed() -> void:
	active_object.queue_free()
	var object: Spatial = ObjectsUtil.next()
	_set_active(object)


func _on_Prev_pressed() -> void:
	active_object.queue_free()
	var object: Spatial = ObjectsUtil.prev()
	_set_active(object)

func _set_active(object: Spatial) -> void:
	active_object = object
	add_child(active_object)
	active_object.transform.origin = active_object.transform.origin + Vector3(0, 9, 0)
	if active_object.has_method("fade_in"):
		active_object.fade_in()


func export_as_base64() -> String:
	var config: Dictionary = {}
	config["version"] = Global.VERSION
	config["objects"] = []
	for object in objects_list:
		var object_config: Dictionary = {}
		object_config["origin"] = object.transform.origin
		object_config["name"] = object.name
		config["objects"].append(object_config)
		
		
	var json: String = str(config)
	print(json)
	return Marshalls.utf8_to_base64(json)


func import_as_base64(value: String) -> String:
	var json: String = Marshalls.base64_to_utf8(value)
	# TODO convet to dict
	# check if level is valid
	return json
