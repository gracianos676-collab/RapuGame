extends Sprite2D

var velocidad = 100

func _ready():
	pass
func _process(delta):
	mover (delta)
	explotar()
func mover(delta):
	position.x += velocidad * delta
	position.y += velocidad * delta
func explotar():
	if position.x > 500:
		print ("UN NIÑO FLOTÓ SOBRE DE MI Y VOLÓ UN AUTO CON SU RAYO LASER")
		queue_free()
