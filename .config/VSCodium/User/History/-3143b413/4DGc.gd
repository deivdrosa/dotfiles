extends Area2D

@export var melee_range: float = 100.0
@export var melee_damage: int = 1
@export var attack_cooldown: float = 0.5

var attack_timer: Timer

func _ready():
    attack_timer = Timer.new()
    attack_timer.wait_time = attack_cooldown
    attack_timer.connect("timeout", self, "_attack")  # ✅ Use method name as string
    attack_timer.start()

func _attack():
    for child in get_tree().get_nodes_in_group("enemy"):
        if child.position.distance_to(global_position) < melee_range:
            child.take_damage(melee_damage)

func _on_MeleeArea_body_entered(body):
    if body.is_in_group("enemy"):
        body.take_damage(melee_damage)