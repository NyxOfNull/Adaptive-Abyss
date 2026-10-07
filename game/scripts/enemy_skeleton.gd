extends CharacterBody2D

@onready var _hp_progress_bar: ProgressBar = $ProgressBar
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

var SPEED = 40
var HEALTH = 100
var DAMAGE = 100

var dead = false
var player_in_area = false
var player

# when the game starts or when this is added to the game scene
func _ready():
	dead = false
	
func _physics_process(delta: float) -> void:
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area: 
			$AnimatedSprite2D.play ("walk")
			position += (player.position - position).normalized() * SPEED * delta
			if player.position.x < position.x:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		if !player_in_area:
			$AnimatedSprite2D.play("idle")
	if dead: 
		$detection_area/CollisionShape2D.disabled = true
		if $AnimatedSprite2D.animation == "death" and not $AnimatedSprite2D.is_playing():
			queue_free()
		return
		




# when something enters the detection area
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body

# when something exits the detection area
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		player = body


func take_damage(amount: int) -> void:
	_hp_progress_bar.value = max(0, _hp_progress_bar.value - amount)
	
	if _hp_progress_bar.value <= 0 and not dead:
		dead = true
		$AnimatedSprite2D.play("death")
	
	_animation_player.play("hit")
	
