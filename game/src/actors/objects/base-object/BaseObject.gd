# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial


onready var animation_player = $AnimationPlayer

export var delay:float = 0

var static_body: StaticBody
var area: Area

var hit:bool = false
var new:bool = true

func _ready() -> void:
	if has_node("Body/Area"):
		area = $Body/Area
	if has_node("Body/MeshInstance/StaticBody"):
		static_body = $Body/MeshInstance/StaticBody
	hide()


func fade_in() -> void:
	if not visible or new:
		new = false
		show()
		animation_player.play("FadeIn")
		yield(animation_player,"animation_finished")
		if delay > 0:
			yield(get_tree().create_timer(delay/10.0), "timeout")
			
		if animation_player.has_animation("Act"):
			animation_player.play("Act")
			
		if has_node("Body/Area"):
			static_body.set_collision_layer_bit(0,true)
			static_body.set_collision_mask_bit(0,true)
			area.set_collision_layer_bit(1,true)
			area.set_collision_mask_bit(1,true)
	
	if hit and animation_player.is_playing():
			hit = false
			yield(animation_player,"animation_finished")
			
			show()
			animation_player.play("FadeIn")
			yield(animation_player,"animation_finished")
			if delay > 0:
				yield(get_tree().create_timer(delay/10.0), "timeout")
			if animation_player.has_animation("Act"):
				animation_player.play("Act")
				
			if area:
				static_body.set_collision_layer_bit(0,true)
				static_body.set_collision_mask_bit(0,true)
				area.set_collision_layer_bit(1,true)
				area.set_collision_mask_bit(1,true)


func _on_Area_body_entered(body) -> void:
	if body.is_in_group("ball"):
		static_body.set_collision_layer_bit(0,false)
		static_body.set_collision_mask_bit(0,false)
		area.set_collision_layer_bit(1,false)
		area.set_collision_mask_bit(1,false)
		hit = true
		animation_player.play("Pop")
		yield(animation_player,"animation_finished")
		hide()
		


