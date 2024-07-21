# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

onready var ball: RigidBody = $Ball
onready var objects: Spatial = $Objects
onready var import_text: TextEdit = $HUD/VBoxContainer/ImportText
onready var camera: Camera = $Base/Camera

var objects_list: Array = []
var active_object: Spatial


func _ready() -> void:
	var object: Spatial = ObjectsUtil.get_object()
	_set_active(object)


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			if active_object != null:
				var mouse_position: Vector2 = get_viewport().get_mouse_position()
				var plane: Plane = Plane(Vector3(0, 0, 10), 0)
				var pos: Vector3 = plane.intersects_ray(camera.project_ray_origin(mouse_position), camera.project_ray_normal(mouse_position))
				active_object.transform.origin.x = pos.x
				active_object.transform.origin.y = pos.y
	elif event is InputEventScreenDrag:
		if active_object != null:
			var mouse_position: Vector2 = get_viewport().get_mouse_position()
			var plane: Plane = Plane(Vector3(0, 0, 10), 0)
			var pos: Vector3 = plane.intersects_ray(camera.project_ray_origin(mouse_position), camera.project_ray_normal(mouse_position))
			active_object.transform.origin.x = pos.x
			active_object.transform.origin.y = pos.y



func _on_Add_pressed():
	var object: Spatial = ObjectsUtil.get_object()
	objects_list.append(object)
	add_child(object)
	# TODO move a bit, replace with animation
	object.transform.origin = Vector3(0, 22, 0)
	if object.has_method("fade_in"):
		object.fade_in()


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
		object_config["x"] = object.transform.origin.x
		object_config["y"] = object.transform.origin.y
		object_config["z"] = object.transform.origin.z
		
		object_config["id"] = object.filename
		config["objects"].append(object_config)
		
	var json: String = JSON.print(config)
	print("export")
	print(json)
	return Marshalls.utf8_to_base64(json)


func import_as_base64(value: String) -> Dictionary:
	var json: String = Marshalls.base64_to_utf8(value)
	# TODO convet to dict
	# check if level is valid
	print("import")
	print(json)
	var json_result: JSONParseResult = JSON.parse(json)
	if json_result.error != OK:
		print("error during level editor import")
		print(value)
		return {}
	var config: Dictionary = json_result.result
	print(config)
	return config


func _on_Export_pressed() -> void:
	var config: String = export_as_base64()
	OS.clipboard = config


func _on_Import_pressed() -> void:
	if import_text.text.length() > 0:
		var text: String = import_text.text
		var config: Dictionary = import_as_base64(text)
		print(config)
		objects_list.clear()
		
		if "objects" in config:
			for object_config in config["objects"]:
				var object:Spatial = ObjectsUtil.get_object_by_id(object_config.id)
				objects_list.append(object)
				add_child(object)
				# TODO move a bit, replace with animation
				var x: float = float(object_config["x"])
				var y: float = float(object_config["y"])
				var z: float = float(object_config["z"])
				
				var origin: Vector3 = Vector3(x, y, z)
				object.transform.origin = origin
				if object.has_method("fade_in"):
					object.fade_in()
		else:
			print("no objects defined in config")

