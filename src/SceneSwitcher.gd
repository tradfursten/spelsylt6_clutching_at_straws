extends Node

var current_scene
var next_scene

var deaths = []

func _ready() -> void:
	Audioplayer.play_song()
	current_scene = $Title
	current_scene.connect("level_completed", self, "_on_level_completed")
	current_scene.connect("level_failed", self, "_on_level_failed")
	SignalManager.connect("cutscene", self, "_on_cutscene")

	SignalManager.connect("restart", self, "_on_restart")
	

func _on_level_completed(current_scene_name) -> void:
	print(current_scene_name + " is complete")
	var next_scene_name: String
	match current_scene_name:
		"Title":
			next_scene_name = "Falling"
		"Falling":
			next_scene_name = "Title"
	get_tree().call_group("blood", "queue_free")
	handle_scene_change(next_scene_name)
			
func _on_level_failed(level_name):
	print("Level failed: " + level_name)
	handle_scene_change("Lose")

func _on_cutscene(cutscene_name):
	print("play cutscene " + cutscene_name)
	next_scene = load("res://src/cutscenes/" + cutscene_name + ".tscn").instance()
	next_scene.connect("level_completed", self, "_on_level_completed")
	next_scene.connect("level_failed", self, "_on_level_failed")
	
	print(next_scene.get_name())
	$AnimationPlayer.play("fade_in")
	
func handle_scene_change(next_scene_name: String) -> void:
	print("switch to " + next_scene_name)
	next_scene = load("res://src/" + next_scene_name + ".tscn").instance()
	next_scene.connect("level_completed", self, "_on_level_completed")
	next_scene.connect("level_failed", self, "_on_level_failed")
	$AnimationPlayer.play("fade_in")
	

	

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_in":
			get_tree().call_group("blood", "queue_free")
			add_child(next_scene)
			current_scene.queue_free()
			current_scene = next_scene
			next_scene = null
			$AnimationPlayer.play("fade_out")
		



func _on_restart():
	print("Restart")
	handle_scene_change("Falling")
