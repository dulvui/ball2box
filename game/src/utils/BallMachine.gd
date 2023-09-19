# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node

var starter = preload("res://src/screens/shop/balls/StarterBall.tscn")
var golden = preload("res://src/screens/shop/balls/GoldenBall.tscn")
var green = preload("res://src/screens/shop/balls/GreenBall.tscn")
var yellow = preload("res://src/screens/shop/balls/YellowBall.tscn")
var football = preload("res://src/screens/shop/balls/Football.tscn")
var volleyball = preload("res://src/screens/shop/balls/Volleyball.tscn")
var pickball = preload("res://src/screens/shop/balls/PickBall.tscn")
var mathball = preload("res://src/screens/shop/balls/MathBall.tscn")
var italyball = preload("res://src/screens/shop/balls/ItalyBall.tscn")
var spainball = preload("res://src/screens/shop/balls/SpainBall.tscn")
var germanyball = preload("res://src/screens/shop/balls/GermanyBall.tscn")
var croatiaball = preload("res://src/screens/shop/balls/CroatiaBall.tscn")
var brasilball = preload("res://src/screens/shop/balls/BrasilBall.tscn")
var japanball = preload("res://src/screens/shop/balls/JapanBall.tscn")
var canadaball = preload("res://src/screens/shop/balls/CanadaBall.tscn")
var chinaball = preload("res://src/screens/shop/balls/ChinaBall.tscn")
var colombiaball = preload("res://src/screens/shop/balls/ColombiaBall.tscn")
var franceball = preload("res://src/screens/shop/balls/FranceBall.tscn")
var indiaball = preload("res://src/screens/shop/balls/IndiaBall.tscn")
var indonesiaball = preload("res://src/screens/shop/balls/IndonesiaBall.tscn")
var mexicoball = preload("res://src/screens/shop/balls/MexicoBall.tscn")
var russiaball = preload("res://src/screens/shop/balls/RussiaBall.tscn")
var ukball = preload("res://src/screens/shop/balls/UKBall.tscn")
var rainbowball = preload("res://src/screens/shop/balls/RainbowBall.tscn")


var golden_real = preload("res://src/actors/ball/golden-ball/GoldenBall.tscn")
var starter_real = preload("res://src/actors/ball/starter-ball/Ball.tscn")
var green_real = preload("res://src/actors/ball/green-ball/GreenBall.tscn")
var yellow_real = preload("res://src/actors/ball/yellow-ball/YellowBall.tscn")
var football_real = preload("res://src/actors/ball/football/Football.tscn")
var volleyball_real = preload("res://src/actors/ball/volleyball/Volleyball.tscn")
var pickball_real = preload("res://src/actors/ball/pick-ball/PickBall.tscn")
var mathball_real = preload("res://src/actors/ball/math-ball/MathBall.tscn")
var italy_real = preload("res://src/actors/ball/italy-ball/ItalyBall.tscn")
var spain_real = preload("res://src/actors/ball/spain-ball/SpainBall.tscn")
var germany_real = preload("res://src/actors/ball/germany-ball/GermanyBall.tscn")
var croatia_real = preload("res://src/actors/ball/croatia-ball/CroatiaBall.tscn")
var brasil_real = preload("res://src/actors/ball/brasil-ball/BrasilBall.tscn")
var japan_real = preload("res://src/actors/ball/japan-ball/JapanBall.tscn")
var canada_real = preload("res://src/actors/ball/canada-ball/CanadaBall.tscn")
var china_real = preload("res://src/actors/ball/china-ball/ChinaBall.tscn")
var colombia_real = preload("res://src/actors/ball/colombia-ball/ColombiaBall.tscn")
var france_real = preload("res://src/actors/ball/france-ball/FranceBall.tscn")
var india_real = preload("res://src/actors/ball/india-ball/IndiaBall.tscn")
var indonesia_real = preload("res://src/actors/ball/indonesia-ball/IndonesiaBall.tscn")
var mexico_real = preload("res://src/actors/ball/mexico-ball/MexicoBall.tscn")
var russia_real = preload("res://src/actors/ball/russia-ball/RussiaBall.tscn")
var uk_real = preload("res://src/actors/ball/uk-ball/UKBall.tscn")
var rainbow_real = preload("res://src/actors/ball/rainbow-ball/RainbowBall.tscn")

@onready var balls = [{"id": 1 , "model":starter, "real": starter_real, "price": 0},
					{"id": 2 ,"model":golden,"real":golden_real, "price": 5},
					{"id": 3 ,"model":green,"real":green_real, "price": tr("MORE_GAMES")},
					{"id": 4 ,"model":yellow,"real":yellow_real, "price": 10},
					{"id": 5 ,"model":football,"real":football_real, "price": tr("FOLLOW")},
					{"id": 6 ,"model":volleyball,"real":volleyball_real, "price": 15},
					{"id": 8 ,"model":pickball,"real":pickball_real, "price": 15},
					{"id": 9 ,"model":mathball,"real":mathball_real, "price": 15},
					{"id": 10 ,"model":japanball,"real":japan_real, "price": 15},
					{"id": 11 ,"model":italyball,"real":italy_real, "price": 15},
					{"id": 12 ,"model":spainball,"real":spain_real, "price": 15},
					{"id": 13 ,"model":germanyball,"real":germany_real, "price": 15},
					{"id": 14 ,"model":croatiaball,"real":croatia_real, "price": 15},
					{"id": 15 ,"model":brasilball,"real":brasil_real, "price": 15},
					{"id": 16 ,"model":canadaball,"real":canada_real, "price": 15},
					{"id": 17 ,"model":chinaball,"real":china_real, "price": 15},
					{"id": 18 ,"model":colombiaball,"real":colombia_real, "price": 15},
					{"id": 19 ,"model":franceball,"real":france_real, "price": 20},
					{"id": 20 ,"model":indiaball,"real":india_real, "price": 20},
					{"id": 21 ,"model":indonesiaball,"real":indonesia_real, "price": 25},
					{"id": 22 ,"model":mexicoball,"real":mexico_real, "price": 25},
					{"id": 23 ,"model":russiaball,"real":russia_real, "price": 25},
					{"id": 24 ,"model":ukball,"real":uk_real, "price": 25},
					{"id": 25 ,"model":rainbowball,"real":rainbow_real, "price": 25},
				]
var current_ball:int = 0
var selected_ball:int = 0

func set_ball_index(index:int) -> void:
	current_ball = index
	selected_ball = index
	
func get_ball_index() -> int:
	return selected_ball

func get_selected() -> Node:
	return balls[selected_ball]["model"].instantiate()

func current_ball_is_selected() -> bool:
	return balls[selected_ball]["id"] == balls[current_ball]["id"]
	
func get_current_ball_info() -> Dictionary:
	return balls[current_ball]
	
func get_real() -> RigidBody3D:
	return balls[selected_ball]["real"].instantiate()

func next() -> PackedScene:
	if current_ball + 1 < balls.size():
		current_ball += 1
	else:
		current_ball = 0
	return balls[current_ball]["model"].instantiate()
	
func prev() -> PackedScene:
	if current_ball - 1 >= 0:
		current_ball -= 1
	else:
		current_ball = balls.size() - 1
	return balls[current_ball]["model"].instantiate()
	
func select() -> void:
	selected_ball = current_ball
