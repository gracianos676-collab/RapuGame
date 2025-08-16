extends Camera2D

@export var objetivo:Node2D

func _process(delta):
	position = objetivo.position
