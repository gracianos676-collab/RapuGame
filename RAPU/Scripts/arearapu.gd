extends Area2D

func _on_area_entered(area):
	print("PILAS >:)")
	area.queue_free()
