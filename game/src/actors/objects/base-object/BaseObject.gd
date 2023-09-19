# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node3D


@onready var animation_player = $AnimationPlayer

@export var delay:float = 0

var hit:bool = false
var new:bool = true

func _ready() -> void:
	hide()
	
func fade_in() -> void:
	if not visible or new:
		new = false
		show()
		animation_player.play("FadeIn")
		await animation_player.animation_finished
		if delay > 0:
			await get_tree().create_timer(delay/10.0).timeout
		if animation_player.has_animation("Act"):
			animation_player.play("Act")
			
		if has_node("Body/Area3D"):
			$Body/MeshInstance3D/StaticBody3D.set_collision_layer_value(0,true)
			$Body/MeshInstance3D/StaticBody3D.set_collision_mask_value(0,true)
			$Body/Area3D.set_collision_layer_value(1,true)
			$Body/Area3D.set_collision_mask_value(1,true)
	
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
				
			if has_node("Body/Area3D"):
				$Body/MeshInstance3D/StaticBody3D.set_collision_layer_value(0,true)
				$Body/MeshInstance3D/StaticBody3D.set_collision_mask_value(0,true)
				$Body/Area3D.set_collision_layer_value(1,true)
				$Body/Area3D.set_collision_mask_value(1,true)


func _on_Area_body_entered(body) -> void:
	if body.is_in_group("ball"):
		$Body/MeshInstance3D/StaticBody3D.set_collision_layer_value(0,false)
		$Body/MeshInstance3D/StaticBody3D.set_collision_mask_value(0,false)
		$Body/Area3D.set_collision_layer_value(1,false)
		$Body/Area3D.set_collision_mask_value(1,false)
		hit = true
		animation_player.play("Pop")
		await animation_player.animation_finished
		hide()
		
