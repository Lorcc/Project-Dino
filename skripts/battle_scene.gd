extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	$background.visible = false
	EventHandler.connect("battle_started", init)
	

func init(character_name, lvl):
	visible = true
	$AnimationPlayer.play("fade_in")
	get_tree().paused = true
	$background/Panel/Label.text = "A wild %s lvl %s appears" %[character_name, lvl]


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$AnimationPlayer.play("fade_out")
		$background.visible = true
		$background/Panel/Fight_Button.grab_focus()

func _on_run_button_pressed() -> void:
	print("hello")
	get_tree().paused = false
	visible = false
	$background.visible = false

func _on_fight_button_pressed() -> void:
	$background/Panel/Label.text = "You can't fight!!"
