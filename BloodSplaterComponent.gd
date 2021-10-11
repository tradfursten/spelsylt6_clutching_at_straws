extends Node2D


export var BloodParticleScene: PackedScene
export var BloodParticleNumber = 15
export var RandomVelocity = 500.0

const BLOOD_SIGNAL_NAME = "on_death"

var rnd = RandomNumberGenerator.new()

func _ready() -> void:
	for parent_signal in get_parent().get_signal_list():
		if parent_signal["name"] == BLOOD_SIGNAL_NAME:
			get_parent().connect(BLOOD_SIGNAL_NAME, self, "_on_parent_death")
			
	rnd.randomize()
	
func _on_parent_death():
	splatter()
	
func splatter(particles_to_spawn := -1):
	if particles_to_spawn <= 0:
		particles_to_spawn = BloodParticleNumber
		
	var spawnedParticle: RigidBody2D
	
	for i in range(particles_to_spawn):
		spawnedParticle = BloodParticleScene.instance()
		get_tree().root.add_child(spawnedParticle)
		spawnedParticle.global_position = global_position
		spawnedParticle.linear_velocity = Vector2(rnd.randf_range(-RandomVelocity, RandomVelocity), rnd.randf_range(-RandomVelocity, RandomVelocity))
