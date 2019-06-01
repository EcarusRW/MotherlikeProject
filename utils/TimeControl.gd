extends Node

onready var time_left=$GeneralTime.time_left
onready var end_dialog=preload("res://menus/EndMenu.tscn")

func _ready():
	if Difficulty.difficulty=="hard":
		$GeneralTime.wait_time=50
	else:
		$GeneralTime.wait_time=25
	$GeneralTime.start()
func _process(_delta):
	time_left=$GeneralTime.time_left
	var time
	if time_left > 1&&time_left<$GeneralTime.wait_time:
		var array_split=str(time_left).split(".")
		time=array_split[0]+":"+array_split[1].substr(0,2)
	else:
		time="¡Se acabo!"
	$CanvasLayer/Label.text=time
func add_time(quantity):
	var new_time=$GeneralTime.time_left
	$GeneralTime.stop()
	$GeneralTime.wait_time=time_left+quantity
	$GeneralTime.start()

func _on_GeneralTime_timeout():
	var end=end_dialog.instance()
	end.change_content("lose")
	$".".add_child(end)
	get_tree().paused=true
