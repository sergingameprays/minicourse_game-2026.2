extends CharacterBody2D

var vida = 3

const SPEED = 400.0
const JUMP_VELOCITY = -1000.0
const FLOOR_LIMIT = 600.0
const MAX_FALL_SPEED = 1000
var direction 
var facing
@onready var cam = $Camera2D
@onready var hurtbox : Area2D = $Hurtbox
# Pega uma clara referencia pro nodo visual
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var arma = $arma

func _ready() -> void:
	facing = -1
	pass
func _physics_process(delta: float) -> void:
	# adiciona gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	velocity.y = clamp(velocity.y, -1000.0, MAX_FALL_SPEED)
	# jump
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# pega o input de movimento
	direction = Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction != 0:
		sprite_2d.flip_h = (direction > 0)
		if (direction != facing):
			arma.position.x = -arma.position.x
		facing = direction
			
		
			
				
	if global_position.y > 1500:
		get_tree().reload_current_scene()
	else:
		move_and_slide()
	
func tomar_dano(dano:int):
	vida -= dano
	if vida <= 0:
		get_tree().reload_current_scene()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if (body.get("dano") == null): 
		return
	tomar_dano(body.dano)
	print(vida)
	print(body)
