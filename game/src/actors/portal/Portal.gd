extends Spatial

signal ball_entered(ball)

func _on_Area_body_entered(body):
	print("body entered")
	if body.is_in_group("ball"):
		print("ball entered")
		emit_signal("ball_entered", body)

