extends RigidBody

class_name Ball

signal reset_ball


onready var geometry_up = $ImmediateGeometryUp
onready var geometry_down = $ImmediateGeometryDown

const SPEED = 1

var shooting = false

var initial_position

func _ready():
	initial_position = transform.origin
	mode = RigidBody.MODE_STATIC




func _process(delta):
	if touch_start != null and touch_pos != null:
		if touch_start.y > touch_pos.y:
			draw_indicator_up()
			geometry_down.clear()
		else:
			draw_indicator_down()
			geometry_up.clear()
	else:
		geometry_up.clear()
		geometry_down.clear()


var touch_pos = null
var touch_start = null
		
func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if event.position.y > 140: # to prevent reset on pause
				
				if shooting:
					reset()
					return true
				# Down
				if touch_start == null:
					touch_start = event.position
		else:
			# Up
			_shoot()
			touch_pos = null
			touch_start = null
		
		return true
	elif event is InputEventScreenDrag:
		# Move
		touch_pos = event.position

	return false

func _shoot():
	if touch_pos != null and touch_start != null and touch_pos.distance_to(touch_start) > 100:
		print("distance %s"%touch_pos.distance_to(touch_start))
		shooting = true
		mode = RigidBody.MODE_RIGID
		var direction = (touch_start - touch_pos)
		print(direction)
		apply_central_impulse(Vector3(- direction.x, direction.y , 0) * SPEED)
	
func reset():
	mode = RigidBody.MODE_STATIC
	shooting = false
	emit_signal("reset_ball")
	translation = initial_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	rotation = Vector3.ZERO
	
func reset_no_signal():
	mode = RigidBody.MODE_STATIC
	shooting = false
	translation = initial_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	rotation = Vector3.ZERO


func _on_Ball_body_entered(body):
	$Sound.play()
	
func draw_indicator_up():

	geometry_up.clear()
	geometry_up.begin(Mesh.PRIMITIVE_TRIANGLES)

	# Prepare attributes for add_vertex.
	geometry_up.set_normal(Vector3(0, 0, 1))
	geometry_up.set_uv(Vector2(0, 0))
	# Call last for each vertex, adds the above attributes.
	geometry_up.add_vertex(Vector3(-0.8, 0, 0))

	geometry_up.set_normal(Vector3(0, -50, 1))
	geometry_up.set_uv(Vector2(0, 1))
	geometry_up.add_vertex(Vector3(0.8, 0, 0))
			
	geometry_up.set_normal(Vector3(0, 0, 1))
	geometry_up.set_uv(Vector2(1, 1))
	geometry_up.set_uv(Vector2(1, 1))
	geometry_up.add_vertex(Vector3(-(touch_pos.x - touch_start.x)/60, (touch_pos.y - touch_start.y)/60, 0))



	geometry_up.end()
	
func draw_indicator_down():

	geometry_down.clear()
	geometry_down.begin(Mesh.PRIMITIVE_TRIANGLES)

	# Prepare attributes for add_vertex.
	geometry_down.set_normal(Vector3(0, 0, 1))
	geometry_down.set_uv(Vector2(0, 0))
	# Call last for each vertex, adds the above attributes.
	geometry_down.add_vertex(Vector3(-0.8, 0, 0))

	geometry_down.set_normal(Vector3(0, -50, 1))
	geometry_down.set_uv(Vector2(0, 1))
	geometry_down.add_vertex(Vector3(0.8, 0, 0))
			
	geometry_down.set_normal(Vector3(0, 0, 1))
	geometry_down.set_uv(Vector2(1, 1))
	geometry_down.set_uv(Vector2(1, 1))
	geometry_down.add_vertex(Vector3((touch_pos.x - touch_start.x)/60, -(touch_pos.y - touch_start.y)/60, 0))

	geometry_down.end()
