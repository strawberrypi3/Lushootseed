extends "res://scenes/menu.gd"




func _on_Button_pressed(): # ALPHABET
	get_tree().change_scene("res://scenes/alphabet.tscn")


func _on_Button2_pressed(): # VOCABULARY
	get_tree().change_scene("res://scenes/vocabulary.tscn")


func _on_Button3_pressed(): # GEOGRAPHY
	get_tree().change_scene("res://scenes/geography.tscn")


func _on_Button4_pressed(): # ABOUT LUSHOOTSEED
	get_tree().change_scene("res://scenes/about.tscn")
