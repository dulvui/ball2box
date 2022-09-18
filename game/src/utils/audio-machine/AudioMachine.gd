extends Node2D

var hits = 0

func hit(final):
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
		
			
func reset():
	hits = 0
	
func click():
	$Hit1.play()

func play_click():
	$Play.play()
