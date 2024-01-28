extends Node

var tutorialControl : Control
var highestIndex : int = -1

func setTutorial(index : int):
	if index > highestIndex:
		tutorialControl.setText(getText(index))
		highestIndex = index

func getTutorial() -> int:
	return highestIndex
		
func getText(i : int) -> String:
	if i == 0:
		return "Use WASD to move around!"
	if i == 1:
		return "Use Space to jump!"
	if i == 2:
		return "Run into an item to pick it up!"
	if i == 3:
		return "Click to throw!"
	if i == 4:
		return "Throw the item at whoever is talking!"
	if i == 5:
		return "Stall the conversation until time runs out!"
	return ""
