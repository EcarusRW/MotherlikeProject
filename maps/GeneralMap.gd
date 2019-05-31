extends Node2D

var items
onready var root=$"."
onready var dialog=preload("res://utils/Dialog.tscn")
onready var box=preload("res://pixel/objects/Ball.tscn")
signal time_bonus

func _ready():
	items=[]
	randomize()
	populate_with_items()

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		items.append(body)
		var timer=Timer.new()
		timer.set_wait_time(0.6)
		timer.connect("timeout",self,"item_despawn",[body,timer])
		$".".add_child(timer)
		timer.start()

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		items.erase(body)
		$TimeControl.add_time(get_time_score(body))

func item_despawn(body,timer):
	body.queue_free()
	timer.stop()
	timer.queue_free()
	
func instance_dialog(context):
	var dialog_instance= dialog.instance()
	dialog_instance.context=context
	root.add_child(dialog_instance)
	$Player.pause_player()

func populate_with_items():
	var total_items=randi()%7+5
	for i in range(0,total_items):
		var instanced_box=box.instance()
		var rnd_x=(randf()*($Spawn_end.position.x-$Spawn_begin.position.x))+$Spawn_begin.position.x
		var rnd_y=(randf()*($Spawn_end.position.y-$Spawn_begin.position.y))+$Spawn_begin.position.y
		instanced_box.position=Vector2(rnd_x,rnd_y)
		root.add_child(instanced_box)

func get_time_score(item_type):
	var time=0
	var item_param=item_type.get_name().split("@")
	var item_name
	if len(item_param)>1:
		item_name=item_param[1]
	else:
		item_name=item_param[0]
	match item_name:
		"Ball":
			time=5
	return time
#Not used functions
func split_triangles(poly):#Fragment polygon (concave) into triangles
	var apex_array=poly.polygon
	var poly_triangles=[]
	for i in range(0,len(apex_array)-2):
		poly_triangles.append([apex_array[0]+poly.position,apex_array[i+1]+poly.position,apex_array[i+2]+poly.position])
	return poly_triangles

func slope(point_a : Vector2,point_b : Vector2):
	return (point_b.y-point_a.y)/(point_b.x-point_a.x)
