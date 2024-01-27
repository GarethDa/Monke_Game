extends Node3D

@export var smallHitTimeStunned : float = 0.5
@export var bigHitTimeStunned : float = 1
var timeLeftStunned : float = 0
var totalTimeStunned : float
@export var audio : AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeLeftStunned:
		timeLeftStunned -= delta
		if timeLeftStunned < 0:
			timeLeftStunned = 0
			audio.volume_db = 0
			return
		totalTimeStunned += delta
		audio.volume_db = -80
	
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Throwable"):
		return
		
	if not body.is_in_group("Big"):
		timeLeftStunned = bigHitTimeStunned
		return
	timeLeftStunned = smallHitTimeStunned
	pass # Replace with function body.
