class_name Rapu
extends CharacterBody2D

const vidamax:int            = 1000
var   vida:int               = vidamax
const energíamax:int         = 100
var energía:int              = energíamax
var velocidad:int            = 300
var brincar:int              = 400
var gravedad:int             = 980
@onready var anima = $AnimatedSprite2D
var teleport        = true
var mirar_izquierda = true
var impulso         = false
var doble_salto     = false
var seg = 0
signal energia
signal vitalidad
var posicion = global_position
enum Estado { 
	Quieto,
	Correr,
	Saltar,
	Caer,
	Tepear}
var Estado_Actual = Estado.Quieto

func _physics_process(delta):
	
	if not is_on_floor() and velocity.y < 500:
		velocity.y += gravedad * delta
	
	match Estado_Actual:
		Estado.Quieto:
			velocity.x = move_toward(velocity.x, 0, velocidad)
			var direction = Input.get_axis("Izquierda", "Derecha")
			var saltar = Input.is_action_just_pressed("Saltar")
			var tp = Input.is_action_just_pressed("Teletransporte") and energía >= 30 and teleport == true
			anima.play("base")
			if direction:
				Estado_Actual = Estado.Correr
			if saltar and is_on_floor():
				Estado_Actual = Estado.Saltar
			if tp:
				Estado_Actual = Estado.Tepear
			impulso = false
			if not is_on_floor():
				Estado_Actual = Estado.Caer 

		Estado.Correr:
			var direction = Input.get_axis("Izquierda", "Derecha")
			var saltar = Input.is_action_just_pressed("Saltar")
			var tp = Input.is_action_just_pressed("Teletransporte") and energía >= 30 and teleport == true
			if direction:
				velocity.x = direction * velocidad
				anima.play("correr")
			else:
				Estado_Actual = Estado.Quieto
			if is_on_floor() and saltar:
				Estado_Actual = Estado.Saltar
			if tp:
				Estado_Actual = Estado.Tepear
			if not is_on_floor():
				Estado_Actual = Estado.Caer
			impulso = true

		Estado.Saltar:
			if is_on_floor():
				doble_salto = true
				velocity.y -= brincar 
			else:
				Estado_Actual = Estado.Caer
				anima.play("saltar")

		Estado.Caer:
			var direction = Input.get_axis("Izquierda", "Derecha")
			var saltar = Input.is_action_just_pressed("Saltar")
			var tp = Input.is_action_just_pressed("Teletransporte") and energía >= 30 and teleport == true
			var freno_aereo = velocidad * 0.1
			if not is_on_floor():
				if doble_salto and saltar:
					velocity.y = 0
					velocity.y -= brincar
					doble_salto = false
				if direction != 0 and impulso == true:
					velocity.x = move_toward(velocity.x, direction * velocidad, freno_aereo)
				elif direction != 0 and impulso == false:
					velocity.x = move_toward(velocity.x, direction * velocidad * 0.6, freno_aereo)
				else:
					freno_aereo = velocidad * 0.03
					velocity.x = move_toward(velocity.x, 0, freno_aereo)
			else:
				Estado_Actual = Estado.Quieto
			if tp:
				Estado_Actual = Estado.Tepear

		Estado.Tepear:	
			teleport = false
			teleport_to_cursor()
			energía -= 10		
			print("Tu energía: ",energía)
			if seg > 2:
				seg = seg - 3
				energia.emit(energía)
			if not is_on_floor():
				Estado_Actual = Estado.Caer
			else:
				Estado_Actual = Estado.Quieto
					

	if Input.is_action_pressed("Hagachar"):
		velocity.y += 100
		print("hagacho :D")
		
	if (mirar_izquierda and velocity.x < 0) or (not mirar_izquierda and velocity.x > 0):
		scale.x *= -1
		mirar_izquierda = not mirar_izquierda
		
func _process(_delta):
	if Input.is_action_just_pressed("Ataque"):
		print("Golpea como todo un bandido")
	if Input.is_action_pressed("Bloqueo"):
		print("Se defiende bien potente")
	
	if Input.is_action_just_pressed("DisparoZ") and energía >= 15:
		print("DISPARO")
		energía -= 15
		
		energia.emit(energía)
	move_and_slide()
func teleport_to_cursor():
	var nueva_posicion
	var mouse_position = get_global_mouse_position()
	#$Estela.visible = true
	global_position = mouse_position
	mouse_position = nueva_posicion
	
func _ready():
	vitalidad.emit(vida)
	energia.emit(energía)
func _on_timer_timeout():
	if energía < energíamax:
		energía += 1
		
		energia.emit(energía)
	if teleport == false:
		if seg < 3:
			seg = seg + 1
			print (seg)
	if seg == 3 and teleport == false:
		teleport = true
		print("teleport activado")
