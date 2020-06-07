extends KinematicBody2D

signal troopDead

var dead = false
var speed = 50
var walking = true
var receivingDamage = false
var life = 2500
var damageTaken

func updateLife():
	var lifeBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("CastleStats").get_node("TroopsLifeBar")
	lifeBar.set_value(life)

func damage():
	if life >= 1:
		life -= damageTaken
	else:
		dead = true
		emit_signal("troopDead")

func _ready():
	$AnimatedSprite.play("Walking")

func _process(delta):
	updateLife()
	
	if receivingDamage == true:
		damage()
	
	var limitTroopPosition = get_tree().get_root().get_node("Main").get_node("LimitDirTroops")
	var dir = (limitTroopPosition.global_position - global_position).normalized()
	
	if walking:
		move_and_collide(dir*speed*delta)

	if dead:
		$AnimatedSprite.play("Dying")
	
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		queue_free()

func _on_TroopDamageArea_area_entered(area):
	if area.is_in_group("OrkEnemy1"):
		damageTaken = 10
		receivingDamage = true
		walking = false
		$AnimatedSprite.play("Attacking")
	elif area.get_parent().name == "LimitDirTroops":
		$AnimatedSprite.play("Idle")

func _on_TroopDamageArea_area_exited(_area):
	receivingDamage = false
	walking = true
	$AnimatedSprite.play("Walking")
