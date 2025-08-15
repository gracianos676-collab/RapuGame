extends Label

func _ready():
	pass

func _process(delta):
	pass

func _on_rapu_energia(energía):
	print("Tu energía es:",energía)
	var texto = "Energía: " + str(energía) + "%"
	text = texto
