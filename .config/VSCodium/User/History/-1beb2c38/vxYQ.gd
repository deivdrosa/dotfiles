extends Node

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 1.0
@export var spawn_position: Vector2

func _ready():
    if enemy_scene == null:
        print("⚠️ enemy_scene não configurado!")
        return
    
    spawn_loop()

func spawn_loop():
    while true:
        spawn_enemy()
        yield(get_tree().create_timer(spawn_interval), "timeout")

func spawn_enemy():
    var enemy = enemy_scene.instance()
    enemy.global_position = spawn_position
    get_tree().get_root().add_child(enemy)