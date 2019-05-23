extends Node2D

var items

func _ready():
	items=[]
	populate_with_items()

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		items.append(body)

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		items.erase(body)

func populate_with_items():
	var triangle_array=split_triangles($SpawnArea.polygon)
	var root=$"."
	var total_items=randi()%7+5
	var box=preload("res://pixel/objects/Box.tscn")
	for i in range(0,total_items):
		randomize()
		#Choose triangle
		var choosen_triangle=triangle_array[randi()%len(triangle_array)]
		#Choose a random position in the triangle
		var rnd_pos=Vector2()

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
func split_triangles(apex_array):#Fragment polygon (concave) into triangles
	var poly_triangles=[]
	for i in range(0,len(apex_array)-2):
		triangles.append([apex_array[0],apex_array[i+1],apex_array[i+2]])
	return poly_triangles
