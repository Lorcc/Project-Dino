extends Control

signal textbox_closed

@onready var textbox = $background/TextBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	textbox.hide()
	$background/PlayerContainer.hide()
	visible = false
	$background.visible = false
	EventHandler.connect("battle_started", init)
	
	await textbox_closed 
	$background/PlayerContainer.show()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP:%d/%d" % [health, max_health]


func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	textbox.show()
	$background/TextBox/Label.text = text

func init(character_name, lvl):
	visible = true
	$AnimationPlayer.play("fade_in")
	get_tree().paused = true
	display_text("A wild %s lvl %s appears" %[character_name, lvl]) 


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$AnimationPlayer.play("fade_out")
		$background.visible = true
		#$background/Panel/Fight_Button.grab_focus()

func _on_run_button_pressed() -> void:
	display_text("Got away safely")
	await textbox_closed
	
	get_tree().paused = false
	visible = false
	$background.visible = false

func _on_fight_button_pressed() -> void:
	#$background/Panel/Label.text = "You can't fight!!"
	pass
