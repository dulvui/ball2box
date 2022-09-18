extends Node

var config

var coins

onready var LEVELS = count_levels()

var current_level = 1

var just_opened = true

var level_stars = [0]

var unlocked_balls

var music
var sfx

func _ready():
	randomize()
	config = ConfigFile.new()
	config.load("user://settings.cfg")
#	if err == OK: # if not, something went wrong with the file loading
	sfx = config.get_value("sfx", "mute", false)
	music = config.get_value("music", "mute", false)
	current_level = config.get_value("current_level", "key", 1)
	unlocked_balls = config.get_value("balls", "unlocked", [1])
	coins = config.get_value("coins", "amount", 0)
	BallMachine.set_ball_index(config.get_value("ball", "selected", 0))
	if config.has_section_key("level", "stars"):
		level_stars = config.get_value("level","stars")
#		if level_stars.size() < LEVELS:
#			for i in LEVELS -1 - level_stars.size():
#				level_stars.append(-1)
	else:
		for i in LEVELS - 1:
			level_stars.append(-1)
		print("level stars setup")
#	for i in LEVELS - level_stars.size():
#			level_stars.append(-1)
			
	print("level amount %s"%level_stars.size())
	
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), sfx)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), music)
	
		
#	if ads and (OS.get_name() == "Android" or OS.get_name() == "iOS"):
#		AdMob.load_banner()
	
		
func save_data():
	config.set_value("music","mute",music)
	config.set_value("sfx","mute",sfx)
	config.set_value("current_level","key",current_level)
	config.set_value("balls","unlocked",unlocked_balls)
	config.set_value("ball","selected", BallMachine.get_index())
	config.set_value("coins","amount",coins)
	config.set_value("level","stars",level_stars)
	config.save("user://settings.cfg")

func set_level_stars(stars):
	if level_stars[current_level - 1] < stars:
		coins += (stars - level_stars[current_level - 1])
		level_stars[current_level - 1] = stars
	save_data()


	
func unlock_next_level():
	if current_level + 1 < LEVELS:
		if level_stars[current_level] == -1:
			level_stars[current_level] = 0
			config.set_value("level","stars",level_stars)
			config.save("user://settings.cfg")

func use_coins(n):
	if coins - n >= 0:
		coins -= n
		return true
	return false
	
func toggle_music():
	music = not music
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), music)
	config.set_value("music","mute",music)
	config.save("user://settings.cfg")
	
func toggle_sfx():
	sfx = not sfx
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), sfx)
	config.set_value("sfx","mute",sfx)
	config.save("user://settings.cfg")

func unlock_ball():
	var ball = BallMachine.get_current_ball_info()
	if unlocked_balls.has(ball["id"]):
		return true
	if ball["price"] is String or use_coins(ball["price"]):
		unlocked_balls.append(ball["id"])
		return true
	return false
	
# to save on close
func _notification(event):
	if event == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST or event == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_data()
	
	
func count_levels():
	var count = 0
	var dir = Directory.new()
	dir.open("res://src/levels/")
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			count += 1;
	return count - 1
	
