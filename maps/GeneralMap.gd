extends Node2D

var items
var total_items
var finished_run=false
onready var root=$"."
onready var dialog=preload("res://utils/Dialog.tscn")
onready var box=preload("res://pixel/objects/Ball.tscn")
onready var photo=preload("res://pixel/objects/Photo.tscn")
onready var end_dialog=preload("res://menus/EndMenu.tscn")
signal time_bonus

func _ready():
	items=[]
	randomize()
	populate_with_items()
	if Difficulty.difficulty=="hard":
		instance_dialog("hard_start",true)
	else:
		instance_dialog("easy_start",true)

func _process(_delta):
	if len(items) >= total_items && !finished_run:
		finished_run=true
		var end=end_dialog.instance()
		end.change_content("win")
		root.add_child(end)
		get_tree().paused=true
		if Difficulty.difficulty=="hard":
			instance_dialog("hard_end",false)
		else:
			instance_dialog("easy_end",false)

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		var timer=Timer.new()
		timer.set_wait_time(0.6)
		timer.connect("timeout",self,"item_despawn",[body,timer])
		$".".add_child(timer)
		timer.start()

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		$TimeControl.add_time(get_time_score(body))

func item_despawn(body,timer):
	items.append(body)
	if (weakref(body).get_ref()):
		body.queue_free()
	timer.stop()
	timer.queue_free()
	
func instance_dialog(context,resume):
	var dialog_instance= dialog.instance()
	dialog_instance.context=context
	if !resume:
		dialog_instance.unpause_game=false
	root.add_child(dialog_instance)

func populate_with_items():
	if Difficulty.difficulty=="easy":
		total_items=randi()%8+5
	else:
		total_items=randi()%10+7
	for i in range(0,total_items):
		var which_item=randi()%2+1
		var instance_of
		if which_item ==1:
			instance_of=box.instance()
		else:
			instance_of=photo.instance()
		var rnd_x=(randf()*($Spawn_end.position.x-$Spawn_begin.position.x))+$Spawn_begin.position.x
		var rnd_y=(randf()*($Spawn_end.position.y-$Spawn_begin.position.y))+$Spawn_begin.position.y
		instance_of.position=Vector2(rnd_x,rnd_y)
		root.add_child(instance_of)

func get_time_score(item_type):
	var time=0
	if Difficulty.difficulty=="easy":
		var item_param=item_type.get_name().split("@")
		var item_name
		if len(item_param)>1:
			item_name=item_param[1]
		else:
			item_name=item_param[0]
		match item_name:
			"Ball":
				time=3
			"Photo":
				time=5
	return time
