extends Node

signal star_hit

onready var animation_player  = $AnimationPlayer

var star_visible = true

func _ready():
	$AnimationPlayer.play("Unpop")

func show_star():
	if not star_visible:
		$AnimationPlayer.play("Unpop")
		star_visible = true

func _on_Area_body_entered(body):
	if body.is_in_group("ball") and star_visible:
		star_visible = false
		print("star hit")
		emit_signal("star_hit")
		animation_player.play("Pop")
