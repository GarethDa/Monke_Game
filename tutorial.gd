extends Control

var timeLeft = 135

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeLeft = 136
	setTime()
	TutorialManager.tutorialControl = self
	TutorialManager.setTutorial(0)
	pass # Replace with function body.

func setText(t : String):
	$Label.text = t
	
func setTime():
	timeLeft-=1
	$Label2.text = "Time left: " + str(timeLeft) + " sec"
	

