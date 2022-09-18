extends Spatial

var ball

func _ready():
	ball = BallMachine.get_selected()
	add_child(ball)

func next():
	ball.next()
	var new_ball = BallMachine.next()
	add_child(new_ball)
	new_ball.fade_in()
	ball = new_ball
	
func prev():
	ball.prev()
	var new_ball = BallMachine.prev()
	add_child(new_ball)
	new_ball.fade_in()
	ball = new_ball
	

func select():
	BallMachine.select()
	
func shop():
	ball.fade_in()
	
func menu():
	yield(get_tree().create_timer(0.2), "timeout") # its ugly whitout
	ball.fade_out()
