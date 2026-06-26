extends CharacterBody2D

@export var speed := 160.0
@export var attack_distance := 36.0

var player
var hp := 3

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		if player == null:
			return

	var distance = global_position.distance_to(player.global_position)
	velocity = global_position.direction_to(player.global_position) * speed
	move_and_slide()

	if distance < attack_distance:
		player.take_damage(1)