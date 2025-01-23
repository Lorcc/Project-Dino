extends CharacterBody2D

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 500


func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction != Vector2.ZERO:
		#right now there is a liniear acceleration which feels kinda janky 
		#TODO increase the acceleration exponentially 
		velocity = velocity.move_toward(input_direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)


func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide()
	
