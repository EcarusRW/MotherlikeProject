extends Node
#onready var dialogoPack = load("res://Dialogo.tscn")
func _ready():
	pass # Replace with function body.

func _on_AreaEvento_body_entered(body):
	$Label.text=str(body)
	$Player._teletransporte($Position2D.position)
	#var dialogo=dialogoPack.instance()
	#get_tree().get_root().add_child(dialogo)
	
