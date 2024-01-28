extends Node3D

@export var smallHitTimeStunned : float = 0.5
@export var bigHitTimeStunned : float = 1
var timeLeftStunned : float = 0
var totalTimeStunned : float
@export var audio : AudioStreamPlayer3D
signal ChangedAnger(angry : bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeLeftStunned:
		timeLeftStunned -= delta
		if timeLeftStunned < 0:
			timeLeftStunned = 0
			ChangedAnger.emit(false)
			return
		totalTimeStunned += delta
	
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Throwable"):
		return
		
	if not body.is_in_group("Big"):
		timeLeftStunned = bigHitTimeStunned
		ChangedAnger.emit(true)
		print("here")
		return
	timeLeftStunned = smallHitTimeStunned
	pass # Replace with function body.
