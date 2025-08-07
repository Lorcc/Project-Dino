extends Area2D

var character_name : String = "Alosaurus"
var lvl : int = 49

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		EventHandler.emit_signal("battle_started", character_name, lvl)
