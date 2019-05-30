extends Node2D

var items

func _ready():
	items=[]
	randomize()
	populate_with_items()

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		items.append(body)
		$Label.text=str(items)
		var timer=Timer.new()
		timer.set_wait_time(0.6)
		timer.connect("timeout",self,"item_despawn",[body,timer])
		$".".add_child(timer)
		timer.start()

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		items.erase(body)
		$Label.text=str(items)

func item_despawn(body,timer):
	body.queue_free()
	timer.stop()
	timer.queue_free()

func populate_with_items():
	var root=$"."
	var total_items=randi()%7+5
	var box=preload("res://pixel/objects/Ball.tscn")
	for i in range(0,total_items):
		var instanced_box=box.instance()
		var rnd_x=(randf()*($Spawn_end.position.x-$Spawn_begin.position.x))+$Spawn_begin.position.x
		var rnd_y=(randf()*($Spawn_end.position.y-$Spawn_begin.position.y))+$Spawn_begin.position.y
		instanced_box.position=Vector2(rnd_x,rnd_y)
		root.add_child(instanced_box)

#Not used functions
func split_triangles(poly):#Fragment polygon (concave) into triangles
	var apex_array=poly.polygon
	var poly_triangles=[]
	for i in range(0,len(apex_array)-2):
		poly_triangles.append([apex_array[0]+poly.position,apex_array[i+1]+poly.position,apex_array[i+2]+poly.position])
	return poly_triangles

func slope(point_a : Vector2,point_b : Vector2):
	return (point_b.y-point_a.y)/(point_b.x-point_a.x)
