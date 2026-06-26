extends CharacterBody2D

const SPEED = 300.0
@export var health := 3

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	look_at(get_global_mouse_position())

func take_damage(amount: int) -> void:
	health -= amount
	print("HP:", health)

	modulate = Color(1, 0.3, 0.3)
	await get_tree().create_timer(0.12).timeout
	modulate = Color.WHITE

	if health <= 0:
		queue_free()