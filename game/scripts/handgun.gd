extends Node2D

@export var distance_from_player := 12.0
@export var minimum_mouse_distance := 0.01

@onready var muzzle: Marker2D = $Marker2D

const BULLET = preload("res://game/scenes/guns/bullet1.tscn")

@onready var player = get_parent()


func _process(delta):
	var mouse_position = get_global_mouse_position()
	var offset = mouse_position - player.global_position

	# Only update the gun when the mouse is far enough away
	if offset.length() > minimum_mouse_distance:
		var direction = offset.normalized()

		# Position
		position = direction * distance_from_player

		# Rotation
		look_at(mouse_position)

		# Flip gun vertically when aiming behind player
		rotation_degrees = wrap(rotation_degrees, 0, 360)

		if rotation_degrees > 90 and rotation_degrees < 270:
			scale.y = -1
		else:
			scale.y = 1
			
		if Input.is_action_just_pressed("fire"):
			var bullet_instance = BULLET.instantiate()
			get_tree().root.add_child(bullet_instance)
			bullet_instance.global_position = muzzle.global_position
			bullet_instance.rotation = rotation
		
