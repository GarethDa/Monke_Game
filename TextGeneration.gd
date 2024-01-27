extends Label3D

var currentDialogue : String
var nextDialogue : String
var currentStrIndex : int = 0
var currentScrollTime : float = 0
var currentStayTime : float = 0
@export var textSpeed : int
@export var stayTime : float
@export var speechBubble : Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready():
	currentDialogue = "this is a test, yes it is, this is just a test."
	nextDialogue = "this is a new test, different from the last test"
	width = speechBubble.texture.get_width() * 2 - speechBubble.texture.get_width() * 0.25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Update the current scroll time
	currentScrollTime += textSpeed * delta
	#Add the next character in the dialogue once the scroll time reaches the threshold 
	if currentScrollTime >= 1 && currentStrIndex < currentDialogue.length():
		currentScrollTime = 0
		text += currentDialogue[currentStrIndex]
		currentStrIndex += 1
		
	#If we have reached the end of the dialogue, wait before setting the dialogue to the next one
	elif currentStrIndex >= currentDialogue.length() && currentDialogue != nextDialogue:
		currentStayTime	+= delta
		if currentStayTime >= stayTime:
			text = ""
			currentDialogue = nextDialogue
			currentStrIndex = 0

func SetNextString(nextString : String):
	nextDialogue = nextString
