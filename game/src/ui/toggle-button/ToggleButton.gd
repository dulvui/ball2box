extends Button

export var normal_texture:Texture
export var pressed_texture:Texture

func _ready() -> void:
	icon = normal_texture


func _on_ToggleButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		icon = pressed_texture
	else:
		icon = normal_texture
