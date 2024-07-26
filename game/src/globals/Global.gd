# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node

const FDROID = false

@onready var VERSION: int = 1

#onready var LEVELS:int = count_levels()
# until new leavels are not ready
@onready var LEVELS: int = 120

var config:ConfigFile

var coins: int
var current_level: int = 1

var show_main: bool = true

var tutorial_swipe_done: bool = false
var tutorial_tap_done: bool = false

var level_stars: Array = [0]

var unlocked_balls: Array

var music: bool
var sfx: bool

var generator_seed: int
var codes: Array
var own_code: String


func _ready() -> void:
	randomize()
	config = ConfigFile.new()
	config.load("user://settings.cfg")
#	if err == OK: # if not, something went wrong with the file loading
	sfx = config.get_value("sfx", "mute", false)
	music = config.get_value("music", "mute", false)
	tutorial_swipe_done = config.get_value("tutorial", "swipe", false)
	tutorial_tap_done = config.get_value("tutorial", "tap", false)
	current_level = config.get_value("current_level", "key", 1)
	unlocked_balls = config.get_value("balls", "unlocked", [1])
	coins = config.get_value("coins", "amount", 0)
	generator_seed = config.get_value("generator", "seed", 0)
	codes = config.get_value("generator", "codes", [])
	own_code = config.get_value("generator", "own_code", "")
	
	BallMachine.set_ball_index(config.get_value("ball", "selected", 0))
	if config.has_section_key("level", "stars"):
		level_stars = config.get_value("level","stars")
		if level_stars.size() < LEVELS:
			for i in LEVELS - level_stars.size():
				level_stars.append(-1)
	else:
		for i in LEVELS - 1:
			level_stars.append(-1)
			
	print("level amount %s"%level_stars.size())
	
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), sfx)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), music)

func save_data() -> void:
	config.set_value("music","mute",music)
	config.set_value("sfx","mute",sfx)
	config.set_value("current_level","key",current_level)
	config.set_value("balls","unlocked",unlocked_balls)
	config.set_value("ball","selected", BallMachine.get_ball_index())
	config.set_value("coins","amount",coins)
	config.set_value("level","stars",level_stars)
	config.set_value("tutorial", "swipe", tutorial_swipe_done)
	config.set_value("tutorial", "tap", tutorial_tap_done)
	config.set_value("generator", "seed", generator_seed)
	config.set_value("generator", "codes", codes)
	config.set_value("generator", "own_code", own_code)
	config.save("user://settings.cfg")

func set_level_stars(stars) -> void:
	if level_stars[current_level - 1] < stars:
		coins += (stars - level_stars[current_level - 1])
		level_stars[current_level - 1] = stars

func unlock_next_level() -> bool:
	if Global.current_level >= Global.LEVELS:
		return false
	if level_stars[current_level] == -1:
		level_stars[current_level] = 0
		return true
	return false

func use_coins(n) -> bool:
	if coins - n >= 0:
		coins -= n
		return true
	return false
	
func toggle_music() -> void:
	music = not music
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), music)
	config.set_value("music","mute",music)
	config.save("user://settings.cfg")
	
func toggle_sfx() -> void:
	sfx = not sfx
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sfx"), sfx)
	config.set_value("sfx","mute",sfx)
	config.save("user://settings.cfg")

# 2 already unlocked
# 1 just unlocked now
# 0 not enough stars
func unlock_ball() -> int:
	var ball = BallMachine.get_current_ball_info()
	if unlocked_balls.has(ball["id"]):
		return 2
	if ball["price"] is String or use_coins(ball["price"]):
		unlocked_balls.append(ball["id"])
		return 1
	return 0
	
# to save on close
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()
		get_tree().quit() # default behavior


func count_levels() -> int:
	var count: int = 0
	var dir: DirAccess = DirAccess.open("res://src/levels/")
	dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	
	var file_name = dir.get_next()
	while file_name != "":
		if file_name != "base-level":
			count += 1
		file_name = dir.get_next()

	return count 
	
