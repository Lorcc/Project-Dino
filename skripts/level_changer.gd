extends Area2D

@export_file("*tscn") var world_scene: String
@export var player_future_position: Vector2
@export var collision_size: Vector2 

func _ready() -> void:
	$CollisionShape2D.shape.size = collision_size

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.goto_scene(world_scene, player_future_position)
