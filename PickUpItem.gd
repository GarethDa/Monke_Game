extends Area3D

@export var player : Node3D
@export var heldItemTransform : RemoteTransform3D
@export var torqueMultiplier : float 
@export var forwardThrowMultiplier : float
@export var upwardThrowMultiplier : float
@export var torqueSizeMultiplier : float
var previousContactsReported : int


		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if not player.pickedUpItem:
			return
		
		heldItemTransform.remote_path = ""
		player.pickedUpItem.remove_from_group("Collected")
		
		player.pickedUpItem.set_freeze_enabled(false)
		player.pickedUpItem.set_max_contacts_reported(previousContactsReported)
		player.pickedUpItem.apply_central_impulse((player.transform.basis.z*forwardThrowMultiplier) + (player.transform.basis.y*upwardThrowMultiplier))
		var sizeMultiplier : float = 1
		
		if player.pickedUpItem.is_in_group("Big"):
			sizeMultiplier = torqueSizeMultiplier
		var torque : Vector3 = Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1))*(torqueMultiplier*sizeMultiplier)
		
		player.mesh.stopCarryingItem()
		player.pickedUpItem.apply_torque(torque)
		print(torque)
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
		previousContactsReported = player.pickedUpItem.get_max_contacts_reported()
		player.pickedUpItem.set_max_contacts_reported(0)
		player.pickedUpItem.add_to_group("Collected")
		player.mesh.carryItem()

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	setPickedUpItem(body)
	pass # Replace with function body.
