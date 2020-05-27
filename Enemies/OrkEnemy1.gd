extends KinematicBody2D

var dead = false;
var speed = 50

func _ready():
	$AnimatedSprite.flip_h = true
	
func _process(delta):
	if dead == false:
		$AnimatedSprite.play("Running")
	
	var castle = get_tree().get_root().get_node("Main").get_node("Castle")
	var dir = (castle.global_position - global_position).normalized()
	
	move_and_collide(dir*speed*delta)


func _on_Area2D_area_entered(area):
	if area.is_in_group("Sword"):
		dead = true
		$AnimatedSprite.play("Dying")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()
