extends Area3D

@export var player : Node3D
@export var heldItemTransform : RemoteTransform3D
var pickedUpItem : Node3D


		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if not pickedUpItem:
			return
		
		heldItemTransform.remote_path = ""
		pickedUpItem.set_freeze_enabled(false)
		pickedUpItem.apply_central_impulse((player.mesh.transform.basis.z*20) + (player.mesh.transform.basis.y*3))
		print("THROW")
		pass
		
func setPickedUpItem(body):
	if not body.is_in_group("Throwable"):
		return
	if not pickedUpItem:
		pickedUpItem = body
		heldItemTransform.remote_path = pickedUpItem.get_path()
		pickedUpItem.set_freeze_enabled(true)

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	setPickedUpItem(body)
	pass # Replace with function body.
