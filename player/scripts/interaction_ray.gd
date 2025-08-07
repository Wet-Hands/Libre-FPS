extends RayCast3D

@export var prompt_label : Label

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var collider = get_collider()

		if collider is Interactable:
			prompt_label.text = collider.name
