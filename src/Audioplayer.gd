extends Node2D

var pick_up = load("res://assets/sound/pick_up.wav")
var hit_ground = load("res://assets/sound/hit_ground.wav")
var activate = load("res://assets/sound/activate.wav")
var fly = load("res://assets/sound/fly.wav")
var burn = load("res://assets/sound/burn.wav")
var chicken_explosion = load("res://assets/sound/chicken_explosion.wav")
var select = load("res://assets/sound/select.wav")
var pick = load("res://assets/sound/pick.wav")


var song = load("res://assets/sound/Clutching At Straws.wav")
var wind = load("res://assets/sound/Vindljud.wav")

func play_pick_up():
	print("audioplayer: play pick up")
	$Effects.stream = pick_up
	$Effects.play()
	
func play_hit_ground():
	print("audioplayer: play hit ground")
	$Effects.stream = hit_ground
	$Effects.play()

func play_activate():
	print("audioplayer: play activate")
	$Effects.stream = activate
	$Effects.play()

func play_fly():
	print("audioplayer: play fly")
	$Effects.stream = fly
	$Effects.play()
	
func play_burn():
	print("audioplayer: play burn")
	$Effects.stream = burn
	$Effects.play()
	
func play_chicken_explosion():
	print("audioplayer: play chicken explosion")
	$Effects.stream = chicken_explosion
	$Effects.play()
	
func play_select():
	print("audioplayer: play select")
	$Effects.stream = select
	$Effects.play()
	
func play_pick():
	print("audioplayer: play pick")
	$Effects.stream = pick
	$Effects.play()
	
func play_song():
	$Music.stream = song
	$Music.play()

func play_wind():
	$wind.stream = wind
	$wind.play()
	
func stop_wind():
	$wind.stop()

func stop():
	$Effects.stream = null
	
