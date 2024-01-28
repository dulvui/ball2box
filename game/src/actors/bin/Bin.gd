# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends RigidBody

signal win

const scale_min:float = 1.01
const scale_max:float = 1.08
const scale_factor:float = 0.001

var scale_up:bool = true

func _integrate_forces(state:PhysicsDirectBodyState) -> void:
	if state.transform.basis.x.x < scale_max and scale_up:
		state.transform.basis.x.x += scale_factor
		state.transform.basis.y.y += scale_factor
		state.transform.basis.z.z += scale_factor
	elif state.transform.basis.x.x > scale_min:
		scale_up = false
		state.transform.basis.x.x -= scale_factor
		state.transform.basis.y.y -= scale_factor
		state.transform.basis.z.z -= scale_factor
	else:
		scale_up = true
	
	
func _on_BallDetector_body_entered(body) -> void:
	if body.is_in_group("ball"):
		$Timer.start()


func _on_Timer_timeout() -> void:
	emit_signal("win")

	
func fade_in() -> void:
	# to match arrow animation
	if Global.current_level > 1:
		# TODO use integrate forces
		pass
	
func hide() -> void:
	visible = false
	collision_layer = 0
	collision_mask = 0
	$BallDetector.monitoring = false
	
func show() -> void:
	visible = true
	collision_layer = 1
	collision_mask = 1
	$BallDetector.monitoring = true
