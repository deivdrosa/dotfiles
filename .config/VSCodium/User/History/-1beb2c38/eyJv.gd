extends Node

@export var enemy_scene: PackedScene
@export var spawn_interval := 1.0
@export var spawn_position := Vector2.ZERO

func _ready():
	if enemy_scene == null:
		print("⚠️ enemy_scene não configurado!")
		return
	
	spawn_loop()

func spawn_loop() -> void:
	while true:
		spawn_enemy()
		await get_tree().create_timer(spawn_interval).timeout

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_position
	get_tree().current_scene.add_child(enemy)