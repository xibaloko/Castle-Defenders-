extends KinematicBody2D

var speed = 50

func _ready():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("Running")
	
func _process(delta):
	var castle = get_tree().get_root().get_node("Main").get_node("Castle")
	var dir = (castle.global_position - global_position).normalized()
	
	move_and_collide(dir*speed*delta)
