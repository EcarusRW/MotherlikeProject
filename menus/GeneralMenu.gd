extends Control

func _ready():
	pass # Replace with function body.

func set_title(text):
	$MarginContainer/VBoxContainer/Title.text=text

func _on_Button_pressed():
	get_tree().change_scene("res://menus/MainMenu.tscn")
