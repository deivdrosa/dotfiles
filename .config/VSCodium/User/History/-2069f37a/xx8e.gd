extends CharacterBody2D

@export var speed := 160.0
@export var attack_distance := 36.0   # ajuste conforme necessário

var player = null
var hp := 3

func _ready():
    player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
    if player == null or not is_instance_valid(player):
        player = get_tree().get_first_node_in_group("player")
        if player == null:
            return
    
    var distance = global_position.distance_to(player.global_position)
    
    velocity = global_position.direction_to(player.global_position) * speed
    move_and_slide()
    
    if distance < attack_distance:
        player_hit()

func player_hit() -> void:
    if player and player.has_method("take_damage"):
        player.take_damage(1)

func take_damage(amount: int) -> void:
    hp -= amount
    if hp <= 0:
        queue_free()