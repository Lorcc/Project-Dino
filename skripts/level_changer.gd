extends Area2D

@export_file("*tscn") var world_scene: String

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.goto_scene(world_scene)
