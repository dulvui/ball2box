# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends RigidBody3D

class_name Ball

const min_geometry_scale := 2
const max_geometry_scale := 6

signal reset
signal shoot

@export var geometry: Node3D

#@onready var geometry_up: GeometryInstance3D = $ImmediateGeometryUp
#@onready var geometry_down: GeometryInstance3D = $ImmediateGeometryDown

@onready var animation_player:AnimationPlayer = $AnimationPlayer


const SPEED:int = 1

var shooting:bool = false

var initial_position:Transform3D

var touch_pos: Vector2
var touch_start: Vector2

var next_transform:Transform3D
var is_teletransporting:bool = false

var shoot_enabled: bool = true


func _ready() -> void:
	initial_position = Transform3D(transform)
	teletransport_to_inital()


func _process(delta:float) -> void:
	if shoot_enabled:
		if touch_start != Vector2.ZERO and touch_pos != Vector2.ZERO:
			draw_indicator(touch_pos)
		else:
			geomtery_clear()
			
			#if touch_start.y > touch_pos.y:
				#draw_indicator_up()
				#geometry_down.clear()
			#else:
				#draw_indicator_down()
				#geometry_up.clear()
		#else:
			#geometry_up.clear()
			#geometry_down.clear()


func _input(event:InputEvent) -> void:
	if shoot_enabled:
		if event is InputEventScreenTouch:
			if event.pressed:
	#			if event.position.y > 140: # to prevent reset on pause
				if shooting:
					reset_position()
				# Down
				if touch_start == Vector2.ZERO:
					touch_start = event.position
			else:
				# Up
				_shoot()
				touch_pos = Vector2.ZERO
				touch_start = Vector2.ZERO
		elif event is InputEventScreenDrag:
			# Move
			touch_pos = event.position


func _shoot() -> void:
	if not shooting and touch_pos != Vector2.ZERO and touch_start != Vector2.ZERO and touch_pos.distance_to(touch_start) > 100:
		geomtery_clear()
		emit_signal("shoot")
		shooting = true
		freeze = false
		#mode = RigidBody3D.MODE_RIGID
		var direction = (touch_start - touch_pos)
		apply_central_impulse(Vector3(- direction.x, direction.y , 0) * SPEED)
		gravity_scale = 1.0


func reset_position() -> void:
	print("reset")
	emit_signal("reset")
	animation_player.play("FadeOut")
	shooting = false
	gravity_scale = 0.0
	await animation_player.animation_finished
	animation_player.play("FadeIn")
	teletransport_to_inital()


func reset_position_no_signal() -> void:
	print("reset no signal")
	shooting = false
	reset_position()
	teletransport_to_inital()


func draw_indicator(dest_pos: Vector2) -> void:
	geometry.show()

	geometry.rotation.z = - get_viewport().get_camera_3d().unproject_position(global_position).angle_to_point(dest_pos) - deg_to_rad(90)
	
	var scale_ratio := get_viewport().get_camera_3d().unproject_position(global_position).distance_to(dest_pos) / 120
	geometry.scale = Vector3(
		clamp(scale_ratio, min_geometry_scale * 2, max_geometry_scale) / 2, 
		clamp(scale_ratio, min_geometry_scale, max_geometry_scale), 
		1
	)


func geomtery_clear() -> void:
	geometry.hide()


#func draw_indicator_up() -> void:
	#if not shooting and touch_start != Vector2.ZERO and touch_pos != Vector2.ZERO:
		#geometry_up.clear()
		#geometry_up.begin(Mesh.PRIMITIVE_TRIANGLES)
#
		## Prepare attributes for add_vertex.
		#geometry_up.set_normal(Vector3(0, 0, 1))
		#geometry_up.set_uv(Vector2(0, 0))
		## Call last for each vertex, adds the above attributes.
		#geometry_up.add_vertex(Vector3(-0.8, 0, 0))
#
		#geometry_up.set_normal(Vector3(0, -50, 1))
		#geometry_up.set_uv(Vector2(0, 1))
		#geometry_up.add_vertex(Vector3(0.8, 0, 0))
				#
		#geometry_up.set_normal(Vector3(0, 0, 1))
		#geometry_up.set_uv(Vector2(1, 1))
		#geometry_up.set_uv(Vector2(1, 1))
		#geometry_up.add_vertex(Vector3(-(touch_pos.x - touch_start.x)/60, (touch_pos.y - touch_start.y)/60, 0))
#
		#geometry_up.end()


#func draw_indicator_down():
	#if not shooting and touch_start != Vector2.ZERO and touch_pos != Vector2.ZERO:
		#geometry_down.clear()
		#geometry_down.begin(Mesh.PRIMITIVE_TRIANGLES)
#
		## Prepare attributes for add_vertex.
		#geometry_down.set_normal(Vector3(0, 0, 1))
		#geometry_down.set_uv(Vector2(0, 0))
		## Call last for each vertex, adds the above attributes.
		#geometry_down.add_vertex(Vector3(-0.8, 0, 0))
#
		#geometry_down.set_normal(Vector3(0, -50, 1))
		#geometry_down.set_uv(Vector2(0, 1))
		#geometry_down.add_vertex(Vector3(0.8, 0, 0))
				#
		#geometry_down.set_normal(Vector3(0, 0, 1))
		#geometry_down.set_uv(Vector2(1, 1))
		#geometry_down.set_uv(Vector2(1, 1))
		#geometry_down.add_vertex(Vector3((touch_pos.x - touch_start.x)/60, -(touch_pos.y - touch_start.y)/60, 0))
#
		#geometry_down.end()


func teletransport(p_transform:Transform3D) -> void:
	next_transform = p_transform
	is_teletransporting = true


func teletransport_to_inital() -> void:
	freeze = true
	#mode = RigidBody3D.FREEZE_MODE_STATIC
	transform.origin = initial_position.origin
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	rotation = Vector3.ZERO


func _integrate_forces(state:PhysicsDirectBodyState3D) -> void:
	if is_teletransporting:
		state.transform = next_transform
		is_teletransporting = false


func _on_Ball_mouse_entered() -> void:
	print("select ball")
