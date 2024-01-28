extends ColorRect

@onready var play_button: Button = find_child("MenuBtn")
@onready var quit_button: Button = find_child("QuitBtn")

func _on_menu_btn_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")
	

func _on_quit_btn_pressed():
	get_tree().quit()
