extends Node2D

var items

func _ready():
	items=[]

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		items.append(body)
		$Label.text=str(items)

func _on_Area2D_body_exited(body):
	if body is RigidBody2D:
		items.erase(body)
		$Label.text=str(items)
