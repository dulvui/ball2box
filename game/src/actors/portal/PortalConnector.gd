# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

export var portalPath1:NodePath
export var portalPath2:NodePath

var portal1:Spatial
var portal2:Spatial

var hit:bool = false

func _ready() -> void:
	portal1 = get_node(portalPath1)
	portal2 = get_node(portalPath2)
	
	portal1.connect("ball_entered", self, "_on_Portal1_ball_entered")
	portal2.connect("ball_entered", self, "_on_Portal2_ball_entered")
	
func reset() -> void:
	hit = false

func _on_Portal1_ball_entered(ball) -> void:
	if not hit:
		hit = true
		ball.teletransport(portal2.transform)
		print("portal 1 teletrasnport")


func _on_Portal2_ball_entered(ball:RigidBody) -> void:
	if not hit:
		hit = true
		ball.teletransport(portal1.transform)
		print("portal 2 teletrasnport")

