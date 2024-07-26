# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node

const DURATON:float = 0.3

@export var node_path:NodePath
@export var node_path2:NodePath

var node:Node
var node2:Node

func _ready() -> void:
	if node_path:
		node = get_node(node_path)
	
	if node_path2:
		node2 = get_node(node_path2)
	
	if node:
		node.modulate = Color(1, 1, 1, 0)
		node.connect("visibility_changed", Callable(self, "fade_in"))
	if node2:
		node2.modulate = Color(1, 1, 1, 0)
		node2.connect("visibility_changed", Callable(self, "fade_in"))
		
		
	fade_in()
	

func fade_in() -> void:
	if node:
		var tween: Tween = get_tree().create_tween()
		node.modulate = Color(1, 1, 1, 0)
		tween.interpolate_property(node, "modulate", 
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), DURATON, 
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	if node2:
		var tween: Tween = get_tree().create_tween()
		node2.modulate = Color(1, 1, 1, 0)
		tween.interpolate_property(node2, "modulate", 
		Color(1, 1, 1, 0), Color(1, 1, 1, 1), DURATON, 
		Tween.TRANS_LINEAR, Tween.EASE_IN)
		start()
