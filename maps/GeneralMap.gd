extends Node2D

var items

func _ready():
	items=[]
	#populate_with_items()
	var box=preload("res://pixel/objects/Ball.tscn")
	for n in range(0,5):
		randomize()
		var instanced_box=box.instance()
		$".".add_child(instanced_box)

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
#func _draw():
	#var triangle_array=split_triangles($SpawnArea)
	#var total_items=randi()%7+5
	#randomize()
	#var choosen_triangle=triangle_array[randi()%len(triangle_array)]
	##Choose a random position in the triangle
	#draw_line(choosen_triangle[0],choosen_triangle[1],Color.white,1.5)
	#draw_line(choosen_triangle[1],choosen_triangle[2],Color.white,1.5)
	#draw_line(choosen_triangle[2],choosen_triangle[0],Color.white,1.5)

	#draw_line(choosen_triangle[1],choosen_triangle[1]+choosen_triangle[2],Color.red,1)
	#draw_line(choosen_triangle[2],choosen_triangle[1]+choosen_triangle[2],Color.red,1)
	#var rnd_x=(choosen_triangle[0].x*randf()+choosen_triangle[1].x*randf()+choosen_triangle[2].x*randf())/3
	#var rnd_y=(choosen_triangle[0].y+choosen_triangle[1].y+choosen_triangle[2].y)/3
	#draw_circle(Vector2(rnd_x,rnd_y),2,Color.red)
	#$Label.text=str(rnd_x)+" / "+str(rnd_y)

func populate_with_items():
	var triangle_array=split_triangles($SpawnArea)
	var root=$"."
	var total_items=randi()%7+5
	var box=preload("res://pixel/objects/Ball.tscn")
	for i in range(0,total_items):
		randomize()
		#Choose triangle
		var choosen_triangle=triangle_array[randi()%len(triangle_array)]
		#Choose a random position in the triangle


	#Despues coger una x y una y aleatorias dentro de los tres vertices

	#Finalmente spawnear el item dentro
	#var n_items=randi()%11+1
	#var root=$"."
	#var box=preload("res://pixel/objects/Box.tscn")
	#for vec in $SpawnArea.polygon:
	#	var instanced_box=box.instance()
	#	instanced_box.position=vec+$SpawnArea.position
	#	root.add_child(instanced_box)
	#
	#for n in range(0,n_items):
	#	randomize()
	#	var instanced_box=box.instance()
	#	instanced_box.position=Vector2(randi()%11+1,randi()%11+1)
	#	root.add_child(instanced_box)
func split_triangles(poly):#Fragment polygon (concave) into triangles
	var apex_array=poly.polygon
	var poly_triangles=[]
	for i in range(0,len(apex_array)-2):
		poly_triangles.append([apex_array[0]+poly.position,apex_array[i+1]+poly.position,apex_array[i+2]+poly.position])
	return poly_triangles
