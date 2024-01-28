extends Node3D

@export var shrinkSpeed : float = 1
@export var toDelete : Node3D
@export var toShrinkMesh : Node3D
@export var RB : RigidBody3D
var originalScale : Vector3
var totalShrank : float
var play : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalScale = toShrinkMesh.scale
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not play:
		return
	totalShrank += delta/shrinkSpeed
	var percent = 1-totalShrank
	toShrinkMesh.scale = originalScale * Vector3(percent,percent,percent)
	RB.gravity_scale = lerp(1,-1,percent)
	if percent < 0:
		toDelete.queue_free()
	pass


