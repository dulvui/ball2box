# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

var objects: Array

var center: Vector3 = Vector3(0, 0, 0)

var camera: Camera


func _ready() -> void:
	camera = get_node("../Base/Camera")
	
	objects = ObjectsUtil.get_all_objects()
	
	for i in objects.size():
		var object: Spatial = objects[i]
		object.translation.x += i * 8
		add_child(object)
		
		# TODO scale
		if abs(object.translation.x) > 0:
			object.scale.x = 0.5
			object.scale.y = 0.5
			object.scale.z = 0.5
		
		
		if object.has_method("fade_in"):
			object.fade_in()
		


func _input(event: InputEvent) -> void:
	if visible:
	#	if event is InputEventScreenTouch:
	#		if event.pressed:

		if event is InputEventScreenDrag:
			var mouse_position: Vector2 = get_viewport().get_mouse_position()
			var plane: Plane = Plane(Vector3(0, 0, 10), 0)
			var pos: Vector3 = plane.intersects_ray(camera.project_ray_origin(mouse_position), camera.project_ray_normal(mouse_position))
			# TODO scroll

