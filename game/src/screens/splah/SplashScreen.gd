extends Control

func _ready() -> void:
	get_tree().change_scene("res://src/levels/Level%s.tscn"%str(Global.current_level))
