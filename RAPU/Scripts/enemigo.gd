class_name Imbecil
extends CharacterBody2D

@export var    velocidad:int = 100
@export var    gravedad:int  = 980
@onready var raycast = $RayCastLeft

enum Estado {
Izquierda,
Derecha
}
var Estado_Actual = Estado.Izquierda
var voltear = false

func _ready():
	print("oaa pua")

func _process(delta):
	pass

func _physics_process(delta):
	
	match Estado_Actual:
		
		Estado.Izquierda:
			var objetivo = raycast.get_collider()	
			velocity.x = -velocidad
			if raycast.is_colliding():
				if objetivo and objetivo.is_in_group("Jugador"):
					print("¡Jugador detectado!")
				elif objetivo:
					scale.x *= -1
					voltear = true
					Estado_Actual = Estado.Derecha

		Estado.Derecha:
			var objetivo = raycast.get_collider()	
			velocity.x = velocidad
			if raycast.is_colliding():
				if objetivo and objetivo.is_in_group("Jugador"):
					print("¡Jugador detectado!")
				elif objetivo:
					scale.x *= -1
					voltear = false
					Estado_Actual = Estado.Izquierda

			

	if not is_on_floor() and velocity.y < 500:
		velocity.y += gravedad * delta
	
	move_and_slide()
