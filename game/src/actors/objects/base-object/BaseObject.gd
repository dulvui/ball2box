# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial


onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var body: Spatial = $Body

export var delay: float = 0

var static_body: StaticBody
var area: Area

var first_fade_in: bool = true


func _ready() -> void:
	if has_node("Body/Area"):
		area = $Body/Area
	if has_node("Body/MeshInstance/StaticBody"):
		static_body = $Body/MeshInstance/StaticBody
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
		yield(animation_player,"animation_finished")
		if delay > 0:
			yield(get_tree().create_timer(delay/10.0), "timeout")

	if animation_player.has_animation("Act"):
		animation_player.play("Act")


func _set_colission(enabled: bool) -> void:
	if area:
		static_body.set_collision_layer_bit(0, enabled)
		static_body.set_collision_mask_bit(0, enabled)
		area.set_collision_layer_bit(1, enabled)
		area.set_collision_mask_bit(1, enabled)


func _on_Area_body_entered(body_entered: Spatial) -> void:
	if body.scale == Vector3.ONE and body_entered.is_in_group("ball"):
		_set_colission(false)
		animation_player.play("Pop")
		yield(animation_player, "animation_finished")
		hide()

