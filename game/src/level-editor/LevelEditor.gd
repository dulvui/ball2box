# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Spatial

onready var ball: RigidBody = $Ball
onready var objects: Spatial = $Objects

var objects_list: Array = []

func _ready() -> void:
	var object: Spatial = ObjectsUtil.get_object()
	objects.add_child(object)
	objects_list.append(object)
	object.fade_in()
#	object.transform.origin = ball.transform.origin
	
	var object2: Spatial = ObjectsUtil.next()
	objects.add_child(object2)
	objects_list.append(object2)
	object2.fade_in()
#	object2.transform.origin = ball.transform.origin

func _on_Add_pressed():
	pass # Replace with function body.


func _on_Undo_pressed():
	pass # Replace with function body.


func _on_Redo_pressed():
	pass # Replace with function body.


func _on_Delete_pressed():
	pass # Replace with function body.
