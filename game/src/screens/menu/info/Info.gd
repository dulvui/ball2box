extends Control

signal back


func _on_Back_pressed() -> void:
	emit_signal("back")


func _on_Website_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://simondalvai.com")


func _on_Github_pressed() -> void:
	AudioMachine.click()
	OS.shell_open("https://github.com/dulvui/ball2box")


func _on_RichTextLabel_meta_clicked(meta) -> void:
	OS.shell_open(meta)
	AudioMachine.click()
