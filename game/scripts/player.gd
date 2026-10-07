extends CharacterBody2D

@export var speed = 100

@onready var animated_sprite = $AnimatedSprite2D

var facing_direction = "down"

func get_input():
	var input_direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	velocity = input_direction * speed

# This function determines where the player is currently facing (mouse direction)
func update_facing_direction():
	var direction = global_position.direction_to(get_global_mouse_position())
	
	if abs(abs(direction.x) - abs(direction.y)) < 0.1:
		return

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			facing_direction = "right"
		else:
			facing_direction = "left"
	else:
		if direction.y > 0:
			facing_direction = "down"
		else:
			facing_direction = "up"

func player():
	pass
	
	
# This function updates the current animation
func update_animation(): 
	if velocity.length() == 0:
		animated_sprite.play("idle_" + facing_direction)
		return
		
	#if abs(velocity.x) > abs(velocity.y):
		#if velocity.x > 0:
			#animated_sprite.play("walk_" + facing_direction) 
		#else: 
			#animated_sprite.play("walk_" + facing_direction)
	#else:
		#if velocity.y > 0:
			#animated_sprite.play("walk_" + facing_direction)
		#else: 
			#animated_sprite.play("walk_" + facing_direction) 
			
	if velocity.length() == 0:
		animated_sprite.play("idle_" + facing_direction)
	else:
		animated_sprite.play("walk_" + facing_direction)

@onready var _hp_progress_bar: ProgressBar = $ProgressBar
var dead: bool = false
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

func take_damage(amount: int) -> void:
	_hp_progress_bar.value = max(0, _hp_progress_bar.value - amount)
	
	if _hp_progress_bar.value <= 0 and not dead:
		dead = true
		$AnimatedSprite2D.play("death")
	
	_animation_player.play("hit")


func _physics_process(delta):
	get_input()
	move_and_slide()
	update_facing_direction()
	update_animation()
