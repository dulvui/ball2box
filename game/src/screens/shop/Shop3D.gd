extends Spatial

var ball

func _ready() -> void:
	ball = BallMachine.get_selected()
	add_child(ball)

func next() -> void:
	ball.next()
	var new_ball = BallMachine.next()
	add_child(new_ball)
	new_ball.fade_in()
	ball = new_ball
	
func prev() -> void:
	ball.prev()
	var new_ball = BallMachine.prev()
	add_child(new_ball)
	new_ball.fade_in()
	ball = new_ball
	

func select() -> void:
	BallMachine.select()
	
func shop() -> void:
	ball.fade_in()
	
func menu() -> void:
	yield(get_tree().create_timer(0.2), "timeout") # its ugly whitout
	ball.fade_out()
