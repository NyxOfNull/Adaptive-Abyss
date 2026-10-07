class_name HurtArea2D extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not area is HitArea2D:
		return

	var hit_area := area as HitArea2D

	if hit_area.owner == owner:
		return

	if owner.has_method("take_damage"):
		owner.take_damage(hit_area.damage)
