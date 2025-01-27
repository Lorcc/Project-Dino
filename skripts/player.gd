extends CharacterBody2D

const ACCELERATION = 450
const MAX_SPEED = 100
const FRICTION = 500
#const WORLD = preload("res://scenes/world.tscn")

const SPEED = 100.0
var current_dir = "none"

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")


func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_direction)
		animation_tree.set("parameters/Walk/blend_position", input_direction)
		animation_state.travel("Walk")
		#right now there is a linear acceleration which feels kinda janky 
		#TODO increase the acceleration exponentially 
		velocity = velocity.move_toward(input_direction * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)
