extends CharacterBody3D


var SPEED = 0
@export var maxSpeed = 5.0
var speedDecrease : float = 0
var speedDecline = 0.01
var minSpeed : float = 2
const JUMP_VELOCITY = 4.5
var move : bool = true
var turnSpeed : float = 15
@export var camera : Camera3D
@export var cameraOrigin : Node3D
@export var mesh : Node3D
var lastPosition : Vector3 = Vector3(0,0,0)
var hasMoved :bool = false
var hasJumped : bool = false

signal moved(index)
signal jumped(index)



func getVelocity() -> Vector2:
	var currentPosition = global_position
	var returner : Vector2 = Vector2(currentPosition.x - lastPosition.x, currentPosition.z - lastPosition.z)	
	lastPosition = global_position
	return returner;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func stopMoving():
	move = false
	gameOver.emit()

signal onPlayerJump
signal gameOver

func _process(delta: float) -> void:
	if !move:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		speedDecrease+=speedDecline
		SPEED = clamp(SPEED-speedDecrease,minSpeed,SPEED)
	else:
		speedDecrease = 0
		SPEED = maxSpeed
	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		emit_signal("onPlayerJump")
		if hasMoved && !hasJumped:
			jumped.emit()
			hasJumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var camera_rotation := cameraOrigin.rotation.y
	direction = direction.rotated(Vector3(0, 1, 0), camera_rotation)
	if direction:
		if !hasMoved:
			moved.emit()
			hasMoved = true
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		mesh.rotation.y = lerp_angle(mesh.rotation.y , atan2(direction.x,direction.z), delta * turnSpeed)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
	

