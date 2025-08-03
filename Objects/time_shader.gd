extends Polygon2D

func _process(delta: float) -> void:
	#changing the color of the bg based on time
	#make this better someone pls (like add colors)
	var brightness : = (World.hour/24)/1.2
	modulate.a = brightness
