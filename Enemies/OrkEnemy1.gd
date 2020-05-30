extends KinematicBody2D

var dead = false
var speed = 50
var causeDamage = false

func _ready():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("Running")

func _process(delta):
	
	var castle = get_tree().get_root().get_node("Main").get_node("Castle")
	var player = get_tree().get_root().get_node("Main").get_node("Player")
	
	var dir = (castle.global_position - global_position).normalized()
	move_and_collide(dir*speed*delta)
	
#	if col and col.collider.name == "Castle":
#		$AnimatedSprite.play("Attacking")
#		castle.life -= 1
#		print(castle.life)
#	elif col and col.collider.name == "Player":
#		$AnimatedSprite.play("Attacking")
#		player.life -= 1
#		print(player.life)
#	else:
#		$AnimatedSprite.play("Running")

func _on_DamageArea_area_entered(area):
	if area.is_in_group("Sword"):
		$AnimatedSprite.play("Dying")
	elif area.is_in_group("OrcsEnemies"):
		var orcEnemy = area.get_parent()
		$AnimatedSprite.play("Attacking")
		orcEnemy.damage()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
