extends "res://menus/GeneralMenu.gd"
onready var node_to_load="res://maps/HouseMap.tscn"
var text
func _ready():
	var archivo=File.new()
	archivo.open("res://json//big_text.json",File.READ)
	text=JSON.parse(archivo.get_as_text()).result

func set_difficulty(level):
	if level=="easy":
		$MarginContainer/VBoxContainer/Desc.text=text["easy"]
	else:
		$MarginContainer/VBoxContainer/Desc.text=text["hard"]
	$MarginContainer/VBoxContainer/Start.visible=true
func _on_Easy_pressed():
	set_difficulty("easy")
	Difficulty.difficulty="easy"

func _on_Hard_pressed():
	set_difficulty("hard")
	Difficulty.difficulty="hard"

func _on_Start_pressed():
	var node_changed=get_tree().change_scene(node_to_load)
	
