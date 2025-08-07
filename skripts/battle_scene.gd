extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	EventHandler.connect("battle_started", init)
	

func init(character_name, lvl):
	visible = true
	get_tree().paused = true
	$background/Panel/Label.text = "A wild %s lvl %s appears" %[character_name, lvl]


func _on_run_button_pressed() -> void:
	print("hello")
	get_tree().paused = false
	visible = false
	$background.visible = false
