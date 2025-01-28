extends Area2D

@export_file("*tscn") var world_scene: String

func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player":
			get_tree().change_scene_to_file(world_scene)
