extends Node3D

#@export_range(0,2) var testSensitivityX : float
#@export_range(0,2) var testSensitivityY : float
@export_range(-2,2) var sensitivityX : float
@export_range(-2,2)var sensitivityY : float
var sensitivityXMulti : float = 1
var sensitivityYMulti : float = 1
@export var player : Node3D
var gameOver : bool = false

func getSensitivity():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	sensitivityX = 0.2#PlayerPrefs.get_pref("HSENS",testSensitivityX)
	sensitivityY = 0.2#PlayerPrefs.get_pref("VSENS",testSensitivityY)

# Called when the node enters the scene tree for the first time.
func _ready():
	getSensitivity()
	pass # Replace with function body.

func _input(event):
	if gameOver:
		return
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(-event.relative.y*sensitivityY*sensitivityYMulti))
		rotation.x = clamp(rotation.x,deg_to_rad((-5)),deg_to_rad((55)))
		player.rotate_y(deg_to_rad(-event.relative.x*sensitivityX*sensitivityXMulti))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_game_over() -> void:
	gameOver = true

