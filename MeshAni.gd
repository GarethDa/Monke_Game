extends Node3D
@export var characterBody : CharacterBody3D
@export var animationTree : AnimationTree
@export var animator : AnimationPlayer
#@export var audioPlayer : AudioStreamPlayer3D
#@export var jumpAudioPlayer : AudioStreamPlayer3D
var isJumpingAnimationOn : bool = false
var idleRunningBlend : float = -1
var idleRunningAdder : float = 0.1
var isJumping : bool
var maxFallRecoveryFrames : float = 15;
var fallRecoveryFrame : float = 0

var maxCarryFrames : float = 15
var carryFrames : float = 0
var carryAddition : float = 0

signal callFootsteps

var moving : bool = true

func playFootsteps():
	if !callFootsteps:
		return
	callFootsteps.emit()
	print("G")

func carryItem():
	carryAddition = 1
	
func stopCarryingItem():
	carryAddition = -1
	
func stopMoving():
	moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !moving:
		idleRunningBlend -= idleRunningAdder
		fallRecoveryFrame+=1
		animationTree.set("parameters/move/blend_position",idleRunningBlend)
		animationTree.set("parameters/fallblend/blend_amount",clamp(fallRecoveryFrame/(maxFallRecoveryFrames*3),0,1))
		return
	if carryAddition != 0:
		carryFrames += carryAddition
		if carryFrames > maxCarryFrames:
			carryFrames = maxCarryFrames
		if carryFrames < 0:
			carryFrames = 0
	animationTree.set("parameters/carry/blend_amount",carryFrames/maxCarryFrames)
	
	var volume : float
	
	if characterBody.velocity.z > 0 || characterBody.velocity.x > 0:
		idleRunningBlend += idleRunningAdder
	elif characterBody.velocity.z < 0 || characterBody.velocity.x < 0:
		idleRunningBlend += idleRunningAdder
	else:
		idleRunningBlend -= idleRunningAdder
		

	
	idleRunningBlend = clamp(idleRunningBlend,-1,1)
	volume = (idleRunningBlend + 1)/2
	
	if characterBody.velocity.z == 0 && characterBody.velocity.x == 0:
		volume = 0
	
	animationTree.set("parameters/move/blend_position",idleRunningBlend)
	if characterBody.velocity.y < 0:
		
		if isJumping == false:
			animationTree.set("parameters/fallblend/blend_amount",clamp(abs(characterBody.velocity.y/4),0,1))
			fallRecoveryFrame = maxFallRecoveryFrames
	
	if characterBody.velocity.y == 0:
		if isJumping == true:			
			
			isJumping = false
			fallRecoveryFrame = 0

			animationTree.set("parameters/jumptrigger/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
			pass
			
		if isJumping == false and fallRecoveryFrame > 0:
			fallRecoveryFrame -= 1
			animationTree.set("parameters/fallblend/blend_amount",clamp(fallRecoveryFrame/maxFallRecoveryFrames,0,1))
	if characterBody.velocity.y != 0:
		volume = 0
		
	takeStep(volume)

func _on_player_on_player_jump() -> void:
	if isJumping == true:
		pass
	animationTree.set("parameters/jumptrigger/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	isJumping = true
	fallRecoveryFrame = 0
	#if !jumpAudioPlayer:
	#	return
	#jumpAudioPlayer.play()
	
func test():
	print("test")
	
func takeStep(blend : float):
	#if !audioPlayer:
	#	return
	#audioPlayer.volume_db = lerp(-80,0,blend)
	pass

