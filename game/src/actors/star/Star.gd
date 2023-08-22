# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node

signal star_hit

onready var animation_player:AnimationPlayer  = $AnimationPlayer

var is_visible:bool = true

# gets enabled if ball has been shooted, to prevent issue
# https://github.com/dulvui/ball2box/issues/2
var is_hitable:bool = false

func _ready():
	$AnimationPlayer.play("Unpop")

func show_star():
	if not is_visible:
		$AnimationPlayer.play("Unpop")

func _on_Area_body_entered(body):
	if body.is_in_group("ball") and is_hitable:
		is_visible = false
		is_hitable = false
		emit_signal("star_hit")
		animation_player.play("Pop")


func _on_AnimationPlayer_animation_finished(anim_name) -> void:
	if anim_name == "Unpop":
		is_visible = true
