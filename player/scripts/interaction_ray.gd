extends RayCast3D

func _physics_process(_delta: float) -> void:
	if is_colliding():
		print("DETECT")
