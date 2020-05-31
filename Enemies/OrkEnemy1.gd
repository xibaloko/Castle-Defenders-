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
	
	if not dead:
		if col and col.collider.name == "Player" or col.collider.name == "Castle":
			$AnimatedSprite.play("Attacking")
		else:
			$AnimatedSprite.play("Running")
	else:
		$AnimatedSprite.play("Dying")

func _on_DyingActionArea_area_entered(area):
	if area.is_in_group("Sword"):
		killingHits -= 1
		if killingHits == 0:
			dead = true
			walking = false
			$AnimatedSprite.play("Dying")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
