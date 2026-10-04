extends CharacterBody2D

var SPEED = 40
var HEALTH = 100
var DAMAGE = 100

var dead = false
var player_in_area = false
var player

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
		


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		player = body
