extends Control

func _ready():
	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))
