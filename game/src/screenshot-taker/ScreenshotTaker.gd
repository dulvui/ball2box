extends Spatial

const resolutions:Dictionary = {
	 "Android" :Vector2(1080,1920),
	 "iPhone5.5" :Vector2(1242, 2208),
	 "iPhone6.5" :Vector2(1284, 2778),
	 "iPhone6.7": Vector2(1290, 2796),
	 "iPad12.9" : Vector2(2048, 2732)
}
	
const scenes:Array = [
	"res://src/levels/Level1.tscn",
	"res://src/levels/Level10.tscn",
	"res://src/levels/Level11.tscn",
	"res://src/levels/Level13.tscn",
	"res://src/levels/Level24.tscn",
	"res://src/levels/Level70.tscn",
	"res://src/levels/Level99.tscn",
	"res://src/levels/Level105.tscn",
]
	
var scene:Node

func _ready() -> void:
	
	var scene_counter:int = 1
	
	for scene in scenes:
		_change_scene(scene)
		for resolution in resolutions.keys():
			OS.set_window_size(resolutions.get(resolution))

			yield(get_tree().create_timer(2), "timeout")
			
			# calculate x/y offset for bigger screens like iPads to center the screenshot
			var x = (resolutions.get(resolution).x - get_viewport().get_texture().get_size().x) / 2
			var y = (resolutions.get(resolution).y - get_viewport().get_texture().get_size().y) / 2
			var fullscreen = Rect2(0 - x, 0 - y, resolutions.get(resolution).x, resolutions.get(resolution).y)
			
			var image = get_viewport().get_texture().get_data().get_rect(fullscreen)
			image.flip_y()
			image.save_png("../screenshots/" + resolution + "-" + str(scene_counter) + ".png")
		scene_counter += 1
	get_tree().quit()
	
	
func _change_scene(scene_path) -> void:
	if scene != null:
		remove_child(scene)
		scene.queue_free()

	var next_scene:Resource = load(scene_path)
	scene = next_scene.instance()
	add_child(scene)
	
	# hide menu
	scene.get_node("UI/Menu").hide()
