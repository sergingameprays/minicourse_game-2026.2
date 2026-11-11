extends CharacterBody2D

@onready var dano = 2
const SPEED = 8000.0
var direction = 1
@export var vida: int = 6

@onready var ray_left: RayCast2D = $left
@onready var ray_right: RayCast2D = $right
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if direction == 1:
		if not ray_right.is_colliding():
			direction = -1
	else: 
		if not ray_left.is_colliding():
			direction = 1
	
	velocity.x = SPEED * delta * direction
	
	sprite.flip_h = (direction < 0)
	
	move_and_slide()
	if is_on_wall():
		direction *= -1

func tomar_dano_inimigo(quantidade: int) -> void:
	vida -= quantidade
	
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
	
	if vida <= 0:
		die()

func die() -> void:
	queue_free()
