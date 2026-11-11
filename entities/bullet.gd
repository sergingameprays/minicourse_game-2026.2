extends Area2D

@export var tempo_vida = 10

var direction
var pos : Vector2
@export var dano = 2
@export var speed = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = pos
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tempo_vida -= delta
	if tempo_vida <= 0:
		queue_free()
		return
	position.x += direction * speed * delta

func _on_body_entered(body : Node) -> void:
	if body.get_collision_layer_value(3):
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	var inimigo = area.get_parent()
	if inimigo and inimigo.has_method("tomar_dano_inimigo"):
		inimigo.tomar_dano_inimigo(dano)
	queue_free()
