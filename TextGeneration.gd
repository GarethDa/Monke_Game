extends Label3D

@export var dialogue : Array[String]
var dialogueIndex : int
var currentStrIndex : int = 0
var currentScrollTime : float = 0
var currentStayTime : float = 0
var paused : bool = false
@export var textSpeed : int
@export var stayTime : float
@export var speechBubbleSprite : Sprite3D
@export var normalSpeech : Texture
@export var angrySpeech : Texture
@export var witnessSpeechPos : Node3D
@export var prosecutorSpeechPos : Node3D
@export var winScreen : ColorRect
@export var loseScreen : ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogueIndex = 0
	width = speechBubbleSprite.texture.get_width() * 2 - speechBubbleSprite.texture.get_width() * 0.25
	speechBubbleSprite.global_position = prosecutorSpeechPos.global_position
	winScreen.visible = false
	loseScreen.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogueIndex >= dialogue.size():
		gameOver(false)
		return
	if !paused:
		#Update the current scroll time
		currentScrollTime += textSpeed * delta
		#Add the next character in the dialogue once the scroll time reaches the threshold 
		if currentScrollTime >= 1 && currentStrIndex < dialogue[dialogueIndex].length():
			currentScrollTime = 0
			text += dialogue[dialogueIndex][currentStrIndex]
			currentStrIndex += 1
			
		#If we have reached the end of the dialogue, wait before setting the dialogue to the next one
		elif currentStrIndex >= dialogue[dialogueIndex].length() && dialogueIndex < dialogue.size():
			currentStayTime	+= delta
			if currentStayTime >= stayTime:
				text = ""
				dialogueIndex+=1
				currentStrIndex = 0
				currentStayTime = 0
				if dialogueIndex % 2 == 0:
					speechBubbleSprite.global_position = prosecutorSpeechPos.global_position
				else:
					speechBubbleSprite.global_position = witnessSpeechPos.global_position

'''
func SetNextString(nextString : String):
	nextDialogue = nextString
'''

func _on_area_3d_changed_anger(angry, username):
	print("set angry")
	if ((username == "Prosecutor" && dialogueIndex % 2 == 0) 
	|| (username == "Witness" && dialogueIndex % 2 == 1)):
		if angry:
			paused = true
			speechBubbleSprite.texture = angrySpeech
			text = "OW!!!"
			font_size = 240
		else:
			paused = false
			speechBubbleSprite.texture = normalSpeech
			text = dialogue[dialogueIndex].substr(0, currentStrIndex + 1)
			font_size = 120
		
func gameOver(win : bool):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if win:
		winScreen.visible = true
		print("WIN")
		return
	loseScreen.visible = true
	print("LOSE")
