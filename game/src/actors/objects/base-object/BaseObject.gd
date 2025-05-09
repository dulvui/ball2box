# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node3D


@onready var animation_player = $AnimationPlayer
@onready var body: Spatial = $Body

@export var delay:float = 0

var static_body: StaticBody3D
var area: Area3D

var first_fade_in: bool = true


func _ready() -> void:
	if has_node("Body/Area3D"):
		area = $Body/Area3D
	if has_node("Body/MeshInstance3D/StaticBody3D"):
		static_body = $Body/MeshInstance3D/StaticBody3D
	hide()


func fade_in() -> void:
	# wait 0.3 seconds to make sure pop animation is finished
	if first_fade_in:
		first_fade_in = false
	else:
		yield(get_tree().create_timer(0.3), "timeout")
	
	_set_colission(true)
	show()

	if body.scale != Vector3.ONE:
		animation_player.play("FadeIn")
		await animation_player.animation_finished
		if delay > 0:
			await get_tree().create_timer(delay/10.0).timeout
			
		if animation_player.has_animation("Act"):
			animation_player.play("Act")
			
		if has_node("Body/Area3D"):
			static_body.set_collision_layer_value(0,true)
			static_body.set_collision_mask_value(0,true)
			area.set_collision_layer_value(1,true)
			area.set_collision_mask_value(1,true)
	
	if hit and animation_player.is_playing():
			hit = false
			await animation_player.animation_finished
			
			show()
			animation_player.play("FadeIn")
			await animation_player.animation_finished
			if delay > 0:
				await get_tree().create_timer(delay/10.0).timeout
			if animation_player.has_animation("Act"):
				animation_player.play("Act")
				
			if area:
				static_body.set_collision_layer_value(0,true)
				static_body.set_collision_mask_value(0,true)
				area.set_collision_layer_value(1,true)
				area.set_collision_mask_value(1,true)


func _on_Area_body_entered(body) -> void:
	if body.scale == Vector3.ONE and body_entered.is_in_group("ball"):
		_set_colission(false)
		animation_player.play("Pop")
		await animation_player.animation_finished
r	hide()


func _set_colission(enabled: bool) -> void:
	if area:
		static_body.set_collision_layer_bit(0, enabled)
		static_body.set_collision_mask_bit(0, enabled)
		area.set_collision_layer_bit(1, enabled)
		area.set_collision_mask_bit(1, enabled)
