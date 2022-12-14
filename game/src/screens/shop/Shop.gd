extends Control

signal next
signal prev
signal back
signal select

onready var animation_player = $AnimationPlayer

func _ready():
	_set_select_label()

func _on_Next_pressed():
	emit_signal("next")
	_set_select_label()
	AudioMachine.click()


func _on_Prev_pressed():
	emit_signal("prev")
	_set_select_label()
	AudioMachine.click()


func set_values(ball):
	var mass_tween = Tween.new()
	add_child(mass_tween)
	mass_tween.interpolate_property($Mass, "value", $Mass.value, ball.mass, 0.4, Tween.EASE_IN, Tween.EASE_OUT)
	mass_tween.start()
	
	var bounce_tween = Tween.new()
	add_child(bounce_tween)
	bounce_tween.interpolate_property($Bounce, "value", $Bounce.value, ball.bounce, 0.4, Tween.EASE_IN, Tween.EASE_OUT)
	bounce_tween.start()
	
	
func _on_Back_pressed():
	AudioMachine.click()
	emit_signal("back")
	


func _on_Select_pressed():
	AudioMachine.play_click()
	var ball = BallMachine.get_current_ball_info()
	if Global.unlocked_balls.has(ball["id"]):
		$Select.text = "select"
	
	elif ball["price"] is String:
		$Select.text = "select"
		if ball["price"] == tr("FOLLOW"):
			OS.shell_open("https://instagram.com/radical.pixels/")
		
		
		elif ball["price"] == tr("RATE"):
			if OS.get_name() == "iOS":
				OS.shell_open("https://itunes.apple.com/app/id1522604143?action=write-review")
			else:
				OS.shell_open("https://play.google.com/store/apps/details?id=com.salvai.ultimatetoss")

		
		elif ball["price"] == tr("MORE_GAMES"):
			if OS.get_name() == "iOS":
				OS.shell_open("https://appstore.com/simondalvai")
			else:
				OS.shell_open("https://play.google.com/store/apps/dev?id=7836644900810357474&hl=en")
	
	
	else:
		if ball["price"] is String:
			$Select.text = str(ball["price"])
		else:
			$Select.text = str(ball["price"])
	emit_signal("select")
		

func _set_select_label():
	var ball = BallMachine.get_current_ball_info()
	if Global.unlocked_balls.has(ball["id"]):
		$Select.text = "select"
		$Star.hide()
		
	else:
		if ball["price"] is String:
			$Select.text = str(ball["price"])
			$Star.hide()
		else:
			$Select.text = str(ball["price"])
			$Star.show()
			
	var ball_instance = ball["real"].instance()
	set_values(ball_instance)
