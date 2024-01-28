extends Area3D

@export var noise : FastNoiseLite
@export var noise_speed := 50.0

@export var shake_reduc_rate := 1.0
@export var max_x := 10.0
@export var max_y := 10.0
@export var max_z := 5.0


var trauma := 0.0

var time := 0.0
@onready var camera := $Camera3D as Camera3D
@onready var initial_rot := camera.rotation_degrees as Vector3

func _process(delta):
	time += delta
	trauma = max(trauma * shake_reduc_rate, 0.0)
	
	camera.rotation_degrees.x = initial_rot.x + max_x + get_shake_intensity() * get_noise_from_seed(0)
	camera.rotation_degrees.y = initial_rot.y + max_y + get_shake_intensity() * get_noise_from_seed(1)
	camera.rotation_degrees.z = initial_rot.z + max_z + get_shake_intensity() * get_noise_from_seed(2)
	
func cause_shake(trauma_amount : float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)
	
func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
