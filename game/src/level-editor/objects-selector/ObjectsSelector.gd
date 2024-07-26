# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node3D

var objects: Array

var center: Vector3 = Vector3(0, 0, 0)

var camera: Camera3D

var is_scrolling: bool = false
var start_scroll: Vector3


func _ready() -> void:
	camera = get_node("../Base/Camera3D")
	
	objects = ObjectsUtil.get_all_objects()
	
	for i in objects.size():
		var object: Node3D = objects[i]
		object.position.x += i * 8
		add_child(object)
		
		if abs(object.position.x) > 0:
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
			
			if not is_scrolling:
				start_scroll = pos
				is_scrolling = true
			
			_scroll_objects(pos)
			
#		else:
#			start_scroll = Vector3.ZERO
#			is_scrolling = false


func _scroll_objects(pos: Vector3) -> void:
	var delta_x: float = start_scroll.x - pos.x
#	print(delta_x)
#	print(pos)
#	print(start_scroll)
	for i in objects.size():
		var object: Node3D = objects[i]
		object.position.x += delta_x
		
		# scale
		if abs(object.position.x) > 0:
			object.scale.x = 0.5
			object.scale.y = 0.5
			object.scale.z = 0.5

