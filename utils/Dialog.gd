extends Node

var unpause_game=true
var texto
var context
var fin=0
var current
var linea=0
var dialogos
var listo_salto=false
var endDialog=false

func _ready():
	get_tree().paused=true
	var archivo=File.new()
	archivo.open("res://json//dialogos.json",File.READ)
	dialogos=JSON.parse(archivo.get_as_text()).result
	current=dialogos[context] #Carga el bloque de conversaciones del contexto
	texto=current[linea][1]
	$Panel/Nombre.text=current[linea][0]#Set titulo y texto
	# 0=Nombre 1=Texto
	# 2= Futuro set de talksprite?

func _process(_delta):
	$Panel/Dialog.text=texto.substr(0,fin)
	if fin>len(texto):#Bloqueo para no pasar rapido
		$Panel/Status.text="›››"
		$Voice.stop()
		if Input.is_action_just_pressed("ui_accept") and linea<len(current)-1:#si esta presionado y el index no se pasa
			linea+=1
			texto=current[linea][1]
			$Panel/Nombre.text=current[linea][0]#Set titulo y texto
			fin=0
		else:
			if linea==len(current)-1&&!endDialog:
				$Panel/Status.text="-->"
				if Input.is_action_just_pressed("ui_accept"):
					endDialog=true
					$SlideDown.interpolate_property($Panel,"position",$Panel.position, $Panel.position+Vector2(0,200), 1,Tween.TRANS_SINE, Tween.EASE_IN)
					$SlideDown.start()
					$Label.text="End"
	else:
		$Panel/Status.text="..."

func Letra_a_letra(): #Y ademas detecta cuando no caben las letras, manualmente
	if fin<=len(texto):
		fin+=1
	if fin%20==0:#Se podria hacer iterable? Merece la pena?
		listo_salto=true
	if listo_salto and texto.substr(fin,1)==" ":
		var salto=texto.substr(0,fin)+"\n"+texto.substr(fin+1,len(texto))
		texto=salto
		listo_salto=false
	$Voice.play()

func _on_SlideDown_tween_completed(_object, _key):
	if unpause_game:
		get_tree().paused=false
	queue_free()
