extends Node2D

var pick_up = load("res://assets/sound/pick_up.wav")
var hit_ground = load("res://assets/sound/hit_ground.wav")

func play_pick_up():
	print("audioplayer: play pick up")
	$Effects.stream = pick_up
	$Effects.play()
	
func play_hit_ground():
	print("audioplayer: play hit ground")
	$Effects.stream = hit_ground
	$Effects.play()

