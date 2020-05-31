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
	var player = get_tree().get_root().get_node("Main").get_node("Player")
	
	var dir = (castle.global_position - global_position).normalized()
	
	if walking:
		var col = move_and_collide(dir*speed*delta)

func _on_DamageArea_area_entered(area):
	var collider = area.get_parent()
	
	if collider.name == "Player" or collider.name == "Castle":
		$AnimatedSprite.play("Attacking")

func _on_DamageArea_area_exited(area):
	$AnimatedSprite.play("Running")

func _on_DyingActionArea_area_entered(area):
	if area.is_in_group("Sword"):
		killingHits -= 1
		if killingHits == 0:
			walking = false
			$AnimatedSprite.play("Dying")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
