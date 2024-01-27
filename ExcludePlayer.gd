extends SpringArm3D

@export var playerExclude : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_excluded_object(playerExclude)
	for child in playerExclude.get_children():
		add_excluded_object(child)

