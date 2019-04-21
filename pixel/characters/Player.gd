extends KinematicBody2D

var velocidad=200
var acel=20
var cansancio=0
var exhausto=false

func _ready():
	pass

func _physics_process(_delta):
	#Movimiento
	var direccion=Vector2()
	if Input.is_action_pressed("ui_up"):
		direccion += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		direccion += Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		direccion += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		direccion += Vector2(1, 0)
	
	#Sprint
	if !exhausto:
		if Input.is_action_pressed("ui_sprint") && direccion!=Vector2(0,0):
			if velocidad<=500:
				velocidad+=acel
			if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
				cansancio+=1
		elif cansancio>0:
			if velocidad>200:
				velocidad-=acel
			cansancio-=1
		if cansancio>=200:
			exhausto=true
			velocidad=100
			$CooldownTimer.start()
	
	direccion= direccion.normalized()*velocidad
	direccion=move_and_slide(direccion)

func _process(_delta):
	pass
	
func _tomar_un_respiro():
	exhausto=false
	cansancio=0
	velocidad=200
	
func _teletransporte(posVector):
	position=posVector