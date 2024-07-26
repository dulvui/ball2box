# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node3D

@onready var box: StaticBody3D = $Bin
@onready var ball: RigidBody3D = $Ball
@onready var objects: Node3D = $Objects

@onready var import_text: TextEdit = $HUD/VBoxContainer/ImportText
@onready var camera: Camera3D = $Base/Camera3D

@onready var objects_button_container: HBoxContainer = $HUD/ScrollContainer/Objects
@onready var box_button: Button = $HUD/ScrollContainer/Objects/Box
@onready var ball_button: Button = $HUD/ScrollContainer/Objects/Ball

var objects_list: Array = []
var active_object: Node3D

var index: int = 0


func _ready() -> void:
#	var object: Spatial = ObjectsUtil.get_object()
#	_set_active(object)
	
#	get_tree().paused = true

	ball.shoot_enabled = false
	
	camera.position.z += 8


func _input(event: InputEvent) -> void:
#	if event is InputEventScreenTouch:
#		if event.pressed:
#			if active_object != null and move.pressed:
#				var mouse_position: Vector2 = get_viewport().get_mouse_position()
#				var plane: Plane = Plane(Vector3(0, 0, 10), 0)
#				var pos: Vector3 = plane.intersects_ray(camera.project_ray_origin(mouse_position), camera.project_ray_normal(mouse_position))
#				active_object.transform.origin.x = pos.x
#				active_object.transform.origin.y = pos.y
	if event is InputEventScreenDrag:
		if active_object != null:
			var mouse_position: Vector2 = get_viewport().get_mouse_position()
			var plane: Plane = Plane(Vector3(0, 0, 10), 0)
			var pos: Vector3 = plane.intersects_ray(camera.project_ray_origin(mouse_position), camera.project_ray_normal(mouse_position))
			active_object.transform.origin.x = pos.x
			active_object.transform.origin.y = pos.y



func _on_Add_pressed():
	var object: Node3D = ObjectsUtil.get_object()
	objects_list.append(object)
	add_child(object)
	# TODO move a bit, replace with animation
	if object.has_method("fade_in"):
		object.fade_in()
	active_object = null
	
	var object_button: Button = Button.new()
	object_button.text = str(index + 1)
	objects_button_container.add_child(object_button)
	object_button.connect("pressed", Callable(self, "on_object_button_pressed").bind(index))
	index += 1
	

func on_object_button_pressed(index: int) -> void:
	active_object = objects_list[index]


func _on_Delete_pressed():
	pass # Replace with function body.


func _on_Next_pressed() -> void:
	if active_object:
		active_object.queue_free()
	var object: Node3D = ObjectsUtil.next()
	_set_active(object)


func _on_Prev_pressed() -> void:
	if active_object:
		active_object.queue_free()
	var object: Node3D = ObjectsUtil.prev()
	_set_active(object)


func _set_active(object: Node3D) -> void:
	active_object = object
	add_child(active_object)
	active_object.transform.origin = Vector3(0, 9, 0)
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
		
	var json: String = JSON.stringify(config)
	print("export")
	print(json)
	return Marshalls.utf8_to_base64(json)


func import_as_base64(value: String) -> Dictionary:
	var json: String = Marshalls.base64_to_utf8(value)
	# TODO convet to dict
	# check if level is valid
	print("import")
	print(json)
	var test_json_conv = JSON.new()
	test_json_conv.parse(json)
	var json_result: JSON = test_json_conv.get_data()
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
				var object:Node3D = ObjectsUtil.get_object_by_id(object_config.id)
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


func _on_CameraZoomIn_pressed() -> void:
	if camera.position.z > 24:
		camera.position.z -= 1


func _on_CameraZoomOut_pressed() -> void:
	if camera.position.z < 56:
		camera.position.z += 1


func _on_Ball_pressed() -> void:
	active_object = ball


func _on_Box_pressed() -> void:
	active_object = box
