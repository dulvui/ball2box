# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends RigidBody

class_name Ball

signal reset
signal shoot



onready var geometry_up:GeometryInstance = $ImmediateGeometryUp
onready var geometry_down:GeometryInstance = $ImmediateGeometryDown

const SPEED:int = 1

var shooting:bool = false

var initial_position:Transform

var touch_pos:Vector2
var touch_start:Vector2

var do_teletransport:bool = false
var do_reset:bool = false
var do_static:bool = false


var next_transform:Transform


func _ready() -> void:
	initial_position = Transform(transform)
	teletransport_to_inital()

func _process(delta:float) -> void:
	if touch_start != Vector2.ZERO and touch_pos != Vector2.ZERO:
		if touch_start.y > touch_pos.y:
			draw_indicator_up()
			geometry_down.clear()
		else:
			draw_indicator_down()
			geometry_up.clear()
	else:
		geometry_up.clear()
		geometry_down.clear()

		
func _input(event:InputEvent) -> void:
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
		emit_signal("shoot")
		print("distance %s"%touch_pos.distance_to(touch_start))
		shooting = true
		mode = RigidBody.MODE_RIGID
		var direction = (touch_start - touch_pos)
		apply_central_impulse(Vector3(- direction.x, direction.y , 0) * SPEED)
	
func reset_position() -> void:
	print("reset")
	emit_signal("reset")
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("FadeIn")
	shooting = false
	
	teletransport_to_inital()
	
func reset_position_no_signal() -> void:
	print("reset no signal")
	shooting = false
	teletransport_to_inital()
	
func draw_indicator_up() -> void:
	if not shooting and touch_start != Vector2.ZERO and touch_pos != Vector2.ZERO:
		geometry_up.clear()
		geometry_up.begin(Mesh.PRIMITIVE_TRIANGLES)

		# Prepare attributes for add_vertex.
		geometry_up.set_normal(Vector3(0, 0, 1))
		geometry_up.set_uv(Vector2(0, 0))
		# Call last for each vertex, adds the above attributes.
		geometry_up.add_vertex(Vector3(-0.8, 0, 0))

		geometry_up.set_normal(Vector3(0, -50, 1))
		geometry_up.set_uv(Vector2(0, 1))
		geometry_up.add_vertex(Vector3(0.8, 0, 0))
				
		geometry_up.set_normal(Vector3(0, 0, 1))
		geometry_up.set_uv(Vector2(1, 1))
		geometry_up.set_uv(Vector2(1, 1))
		geometry_up.add_vertex(Vector3(-(touch_pos.x - touch_start.x)/60, (touch_pos.y - touch_start.y)/60, 0))

		geometry_up.end()
	
func draw_indicator_down():
	if not shooting and touch_start != Vector2.ZERO and touch_pos != Vector2.ZERO:
		geometry_down.clear()
		geometry_down.begin(Mesh.PRIMITIVE_TRIANGLES)

		# Prepare attributes for add_vertex.
		geometry_down.set_normal(Vector3(0, 0, 1))
		geometry_down.set_uv(Vector2(0, 0))
		# Call last for each vertex, adds the above attributes.
		geometry_down.add_vertex(Vector3(-0.8, 0, 0))

		geometry_down.set_normal(Vector3(0, -50, 1))
		geometry_down.set_uv(Vector2(0, 1))
		geometry_down.add_vertex(Vector3(0.8, 0, 0))
				
		geometry_down.set_normal(Vector3(0, 0, 1))
		geometry_down.set_uv(Vector2(1, 1))
		geometry_down.set_uv(Vector2(1, 1))
		geometry_down.add_vertex(Vector3((touch_pos.x - touch_start.x)/60, -(touch_pos.y - touch_start.y)/60, 0))

		geometry_down.end()

func teletransport(p_transform:Transform) -> void:
	next_transform = p_transform
	do_teletransport = true
	print("teletransport " + str(next_transform))
	
func teletransport_to_inital() -> void:
	print("teletransport to inital")
	do_reset = true

func _integrate_forces(state:PhysicsDirectBodyState) -> void:
	# to change the mode to staric on the next iteration
	# otherwhise ball doesn't move to new position
	if do_static:
		do_static = false
		mode = RigidBody.MODE_STATIC
	
	if do_teletransport:
		mode = RigidBody.MODE_RIGID
		state.transform = next_transform
		do_teletransport = false
		
	if do_reset:
		state.transform = initial_position
		state.angular_velocity = Vector3.ZERO
		state.linear_velocity = Vector3.ZERO
		rotation = Vector3.ZERO
		do_reset = false
		do_static = true

