extends CharacterBody2D

@export var speed := 120.0
@export var damage := 1
@export var attack_distance := 30.0

var player: Node2D = null
var hp := 120

func _ready():
    player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
    if player == null or not is_instance_valid(player):
        player = get_tree().get_first_node_in_group("player")
        if player == null:
            return
    
    var dir = global_position.direction_to(player.global_position)
    velocity = dir * speed
    move_and_slide()
    
    if global_position.distance_to(player.global_position) < attack_distance:
        player_hit()

func player_hit() -> void:
    if player and player.has_method("take_damage"):
        print("Enemy: ATACANDO O PLAYER!")
        player.take_damage(damage)
    else:
        print("Enemy: Player não tem take_damage!")

func take_damage(amount: int) -> void:
    hp -= amount
    print("HP do enemy: ", hp)
    if hp <= 0:
        print("Enemy morreu!")
        queue_free()