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

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		items.erase(body)
		$Label.text=str(items)

func populate_with_items():
	var n_items=randi()%11+1
	var root=$"."
	var box=preload("res://pixel/objects/Box.tscn")
	for vec in $SpawnArea.polygon:
		var instanced_box=box.instance()
		instanced_box.position=vec+$SpawnArea.position
		root.add_child(instanced_box)
		$Label.text+=str(vec)
	#for n in range(0,n_items):
	#	var instanced_box=box.instance()
	#	instanced_box.position=Vector2(30,30)
	#	root.add_child(instanced_box)
		