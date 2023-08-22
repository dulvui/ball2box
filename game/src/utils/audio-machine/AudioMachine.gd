# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Node2D

var hits:int = 0

func hit(final) -> void:
	if not final:
		hits+=1
		match hits:
			2:
				$Hit2.play()
			3:
				$Hit3.play()
			_:
				$Hit1.play()
	else:
		$Hit3.play()
		
			
func reset() -> void:
	hits = 0
	
func click() -> void:
	$Hit1.play()

func play_click() -> void:
	$Play.play()
