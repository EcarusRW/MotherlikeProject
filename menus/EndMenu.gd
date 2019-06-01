extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _on_NewGame_pressed():
	get_tree().paused=false
	get_tree().change_scene("res://maps/HouseMap.tscn")

func _on_Exit_pressed():
	get_tree().paused=false
	get_tree().change_scene("res://menus/NewGame.tscn")

func change_content(state):
	var file=File.new()
	file.open("res://json//end_menu.json",File.READ)
	var text=JSON.parse(file.get_as_text()).result
	$ColorRect/MarginContainer/VBoxContainer/Win_Lose.text=text[state][0]
	$ColorRect/MarginContainer/VBoxContainer/Desc.text=text[state][1]