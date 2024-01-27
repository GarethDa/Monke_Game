extends Area3D

@export var player : Node3D
@export var heldItemTransform : RemoteTransform3D



		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if not player.pickedUpItem:
			return
		
		heldItemTransform.remote_path = ""
		player.pickedUpItem.set_freeze_enabled(false)
		player.pickedUpItem.apply_central_impulse((player.mesh.transform.basis.z*20) + (player.mesh.transform.basis.y*3))
		player.pickedUpItem = null
		print("THROW")
		pass
		
func setPickedUpItem(body):
	if not body.is_in_group("Throwable"):
		return
	if not player.pickedUpItem:
		player.pickedUpItem = body
		heldItemTransform.remote_path = player.pickedUpItem.get_path()
		player.pickedUpItem.set_freeze_enabled(true)

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	setPickedUpItem(body)
	pass # Replace with function body.
