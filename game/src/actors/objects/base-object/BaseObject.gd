# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial


onready var animation_player: AnimationPlayer = $AnimationPlayer

export var delay: float = 0

var static_body: StaticBody
var area: Area

var hit: bool = false


func _ready() -> void:
	if has_node("Body/Area"):
		area = $Body/Area
	if has_node("Body/MeshInstance/StaticBody"):
		static_body = $Body/MeshInstance/StaticBody
	hide()


func fade_in() -> void:
	_set_colission(false)
	if animation_player.is_playing():
		yield(animation_player,"animation_finished")

	show()

	animation_player.play("FadeIn")
	yield(animation_player,"animation_finished")
	if delay > 0:
		yield(get_tree().create_timer(delay/10.0), "timeout")
			
	if animation_player.has_animation("Act"):
		animation_player.play("Act")

	_set_colission(true)
	hit = false	


func _set_colission(enabled: bool) -> void:
	if area:
		static_body.set_collision_layer_bit(0, enabled)
		static_body.set_collision_mask_bit(0, enabled)
		area.set_collision_layer_bit(1, enabled)
		area.set_collision_mask_bit(1, enabled)


func _on_Area_body_entered(body) -> void:
	if body.is_in_group("ball") and not hit:
		static_body.set_collision_layer_bit(0,false)
		static_body.set_collision_mask_bit(0,false)
		area.set_collision_layer_bit(1,false)
		area.set_collision_mask_bit(1,false)
		animation_player.play("Pop")
		yield(animation_player,"animation_finished")
		hide()	


