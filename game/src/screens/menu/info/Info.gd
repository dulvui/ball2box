extends CenterContainer

signal back

func _ready() -> void:
	$VBoxContainer/Buttons/Donate.visible = Global.FDROID or OS.get_name() == "HTML5"
	$VBoxContainer/Buttons/Website.visible = not $VBoxContainer/Buttons/Donate.visible

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


func _on_Donate_pressed():
	AudioMachine.click()
	OS.shell_open("https://simondalvai.com/donate")
