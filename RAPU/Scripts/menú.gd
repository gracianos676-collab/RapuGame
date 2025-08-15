extends Node

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/prueba.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
