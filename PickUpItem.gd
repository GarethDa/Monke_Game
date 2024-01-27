extends Area3D

@export var player : Node3D
var pickedUpItem : Node3D

		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if not pickedUpItem:
			return
		
		
		pickedUpItem.apply_central_impulse(player.mesh.transform.basis.z*20)
		print("THROW")
		pass
		
func setPickedUpItem(body):
	if not body.is_in_group("Throwable"):
		return
	if not pickedUpItem:
		pickedUpItem = body

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	setPickedUpItem(body)
	pass # Replace with function body.
