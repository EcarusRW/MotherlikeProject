extends KinematicBody2D

onready var animations=$Pasos/AnimationPlayer
var velocidad
var acel
var cansancio
var exhausto
var validMoveset
var direccion
var pressed_keys

func _ready():
	exhausto=false
	cansancio=0
	acel=5
	velocidad=100
	validMoveset=[
		"Walkup",
		"Walkdown",
		"Walkleft",
		"Walkright",
		"Walkupleft",
		"Walkupright",
		"Walkdownleft",
		"Walkdownright"]

func _physics_process(_delta):
	#Movimiento
	direccion=Vector2()
	pressed_keys=0
	if Input.is_action_pressed("ui_up"):
		direccion += Vector2(0, -1)
		pressed_keys+=1
	if Input.is_action_pressed("ui_down"):
		direccion += Vector2(0, 1)
		pressed_keys+=1
	if Input.is_action_pressed("ui_left"):
		direccion += Vector2(-1, 0)
		pressed_keys+=1
	if Input.is_action_pressed("ui_right"):
		direccion += Vector2(1, 0)
		pressed_keys+=1
	if pressed_keys>2:
		direccion=Vector2(0,0)
	#Sprint
	if !exhausto:
		if Input.is_action_pressed("ui_sprint") && direccion!=Vector2(0,0):
			if velocidad<=300:
				velocidad+=acel
			if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
				cansancio+=1
		elif cansancio>0:
			if velocidad>100:
				velocidad-=acel
			cansancio-=1
		if cansancio>=200:
			exhausto=true
			velocidad=50
			$CooldownTimer.start()
	
	direccion= direccion.normalized()*velocidad
	direccion=move_and_slide(direccion)

func _input(event):
	var state = "Walk"
	if Input.is_action_pressed("ui_up"):
		state += "up"
	if Input.is_action_pressed("ui_down"):
		state += "down"
	if Input.is_action_pressed("ui_left"):
		state += "left"
	if Input.is_action_pressed("ui_right"):
		state += "right"
	if state in validMoveset:
		animations.play(state)
	else:
		animations.stop()

func _process(_delta):
	pass

func _tomar_un_respiro():
	exhausto=false
	cansancio=0
	velocidad=100

func _teletransporte(posVector):
	position=posVector
