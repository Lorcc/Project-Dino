extends Control

signal textbox_closed

@export var enemy : Resource = null

var current_player_health = 0
var current_enemy_health = 0

func _ready() -> void:
	set_health($EnemyContainer/VBoxContainer/EnemyPanel/EnemyData/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerContainer/HBoxContainer/PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	
	visible = false
	$TextBox.hide()
	$PlayerContainer.hide()
	
	EventHandler.connect("battle_started", init)
	
	await textbox_closed 
	$PlayerContainer.show()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]


func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$TextBox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$TextBox.show()
	$TextBox/Label.text = text

func init(character_name, lvl):
	visible = true
	$AnimationPlayer.play("fade_in")
	get_tree().paused = true
	display_text("A wild %s lvl %s appears" %[character_name, lvl]) 

func enemy_turn():
	display_text("The %s launches at your alosaurus fiercely!" % enemy.name)
	await textbox_closed
	
	current_player_health = max(0, current_player_health - enemy.damage)
	set_health($PlayerContainer/HBoxContainer/PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
	
	$AnimationPlayer.play("player_damaged")
	await "animation_finished"

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$AnimationPlayer.play("fade_out")
		

func _on_run_button_pressed() -> void:
	display_text("Got away safely")
	await textbox_closed
	
	get_tree().paused = false
	visible = false


func _on_attack_button_pressed() -> void:
	display_text("Your alosaurus charges forward and bites the enemy!")
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health($EnemyContainer/VBoxContainer/EnemyPanel/EnemyData/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damaged")
	await "animation_finished"
	
	enemy_turn()
