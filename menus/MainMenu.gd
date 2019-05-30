extends Control
var testDebug

func _ready():
	testDebug=$MarginContainer/TitleMenus/Title
	for option in get_tree().get_nodes_in_group("MainMenuOptions"):
		option.connect("mouse_entered",self, "on_option_mouse_entered",[option])
		option.connect("mouse_exited",self, "on_option_mouse_exited",[option])
		option.connect("pressed",self, "on_option_press",[option])

func on_option_mouse_entered(which):
	$Selector.visible=true
	$Selector.rect_position=which.get_global_transform().get_origin()+Vector2(which.rect_size.x+5,5)

func on_option_mouse_exited(which):
	$Selector.visible=false

func on_option_press(which):
	#Resource string builder
	var path="res://menus/"
	match which.get_name():
		"NewGameButton":
			path+="GeneralMenu.tscn"
		"HelpButton":
			path+="GeneralMenu.tscn"
		"ExitButton":
			path+="GeneralMenu.tscn"
	get_tree().change_scene(path)