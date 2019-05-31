extends Node

onready var time_left=$GeneralTime.time_left

func _ready():
	pass
func _process(_delta):
	time_left=$GeneralTime.time_left
	var time
	var array_split
	if time_left > 1:
		array_split=str(time_left).split(".")
		time=array_split[0]+":"+array_split[1].substr(0,2)
	else:
		time="¡Se acabo!"
	$CanvasLayer/Label.text=time
func add_time(quantity):
	var new_time=$GeneralTime.time_left
	$GeneralTime.stop()
	$GeneralTime.wait_time=time_left+quantity
	$GeneralTime.start()