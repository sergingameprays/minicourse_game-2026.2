extends Node2D

@export var bullet_scene: PackedScene
@onready var cano = $Marker2D

var fire_timer
@export var fire_cooldown = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (fire_timer > 0):
		fire_timer -= delta
	elif Input.is_action_just_pressed("disparo"):
		fire()
		
func fire():
	var bullet = bullet_scene.instantiate()
	bullet.pos = cano.global_position
	bullet.direction = get_parent().facing
	get_tree().current_scene.add_child(bullet)
	fire_timer = fire_cooldown
