extends Area2D

@export var melee_range: float = 100.0
@export var melee_damage: int = 1
@export var attack_cooldown: float = 0.5

var attack_timer: Timer

func _ready():
	attack_timer = Timer.new()
	add_child(attack_timer)

	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = false

	attack_timer.timeout.connect(_attack)
	attack_timer.start()

func _attack():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		if enemy and is_instance_valid(enemy):
			if enemy.global_position.distance_to(global_position) < melee_range:
				enemy.take_damage(melee_damage)
