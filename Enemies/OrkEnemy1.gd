extends KinematicBody2D

var dead = false
var speed = 50
var walking = true
var killingHits = 2

func _ready():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("Running")

func _process(delta):
	var castle = get_tree().get_root().get_node("Main").get_node("Castle")
	var dir = (castle.global_position - global_position).normalized()
	var col
	
	if walking:
		col = move_and_collide(dir*speed*delta)
	
	if dead:
		$AnimatedSprite.play("Dying")
	else:
		if col and col.collider.name == "Player":
			$AnimatedSprite.play("Attacking")
		elif col && col.collider.name == "Castle":
			$AnimatedSprite.play("Attacking")
		else:
			$AnimatedSprite.play("Running")

func _on_DyingActionArea_area_entered(area):
	if area.is_in_group("Sword"):
		killingHits -= 1
		if killingHits == 0:
			add_collision_exception_with(get_tree().get_root().get_node("Main").get_node("Player"))
			dead = true
			walking = false
			$AnimatedSprite.play("Dying")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
