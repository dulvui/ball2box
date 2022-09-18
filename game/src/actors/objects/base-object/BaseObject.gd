extends Spatial


onready var animation_player = $AnimationPlayer

export var delay = 0

var hit = false
var new = true

func _ready():
	hide()
	
func fade_in():
	if not visible or new:
		new = false
		show()
		print("fade in object")
		animation_player.play("FadeIn")
		yield(animation_player,"animation_finished")
		if delay > 0:
			yield(get_tree().create_timer(delay/10.0), "timeout")
		if animation_player.has_animation("Act"):
			animation_player.play("Act")
			
		if has_node("Body/Area"):
			$Body/MeshInstance/StaticBody.set_collision_layer_bit(0,true)
			$Body/MeshInstance/StaticBody.set_collision_mask_bit(0,true)
			$Body/Area.set_collision_layer_bit(1,true)
			$Body/Area.set_collision_mask_bit(1,true)
	
	if hit and animation_player.is_playing():
			hit = false
			yield(animation_player,"animation_finished")
			
			show()
			print("fade in object")
			animation_player.play("FadeIn")
			yield(animation_player,"animation_finished")
			if delay > 0:
				yield(get_tree().create_timer(delay/10.0), "timeout")
			if animation_player.has_animation("Act"):
				animation_player.play("Act")
				
			if has_node("Body/Area"):
				$Body/MeshInstance/StaticBody.set_collision_layer_bit(0,true)
				$Body/MeshInstance/StaticBody.set_collision_mask_bit(0,true)
				$Body/Area.set_collision_layer_bit(1,true)
				$Body/Area.set_collision_mask_bit(1,true)


func _on_Area_body_entered(body):
	if body.is_in_group("ball"):
		$Body/MeshInstance/StaticBody.set_collision_layer_bit(0,false)
		$Body/MeshInstance/StaticBody.set_collision_mask_bit(0,false)
		$Body/Area.set_collision_layer_bit(1,false)
		$Body/Area.set_collision_mask_bit(1,false)
		hit = true
		animation_player.play("Pop")
		yield(animation_player,"animation_finished")
		hide()
		
