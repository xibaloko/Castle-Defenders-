extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const SPEED = 50
const JUMP_HEIGHT = -300

var life = 2500
var energy = 50
var isAttacking = false
var receivingDamage = false
var damageTaken

var motion = Vector2()

func damage():
	life -= damageTaken

func updateLifeAndEnergyBar():
	var lifeBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("PlayerStats").get_node("PlayersLifeBar")
	var energyBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("PlayerStats").get_node("PlayersEnergyBar")
	lifeBar.set_value(life)
	energyBar.set_value(energy)

func _physics_process(delta):
	updateLifeAndEnergyBar()
	
	if receivingDamage == true:
		damage()
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right") && isAttacking == false:
		motion.x = SPEED
		$AnimatedSprite.play("Running")
		$AnimatedSprite.flip_h = false
		get_node("AttackArea").set_scale(Vector2(1, 1))
	elif Input.is_action_pressed("ui_left") && isAttacking == false:
		motion.x = -SPEED
		$AnimatedSprite.play("Running")
		$AnimatedSprite.flip_h = true
		get_node("AttackArea").set_scale(Vector2(-1, 1))
	else:
		motion.x = 0
		if isAttacking == false:
			$AnimatedSprite.play("Idle")
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	if Input.is_action_just_pressed("Attack"):
		$AnimatedSprite.play("Attacking")
		isAttacking = true
		$AttackArea/CollisionShape2D.disabled = false
	
	motion = move_and_slide(motion, UP)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attacking":
		$AttackArea/CollisionShape2D.disabled = true
		isAttacking = false

func _on_PlayersDamageArea_area_entered(area):
	var collider = area.get_parent()
	
	if collider.name == "OrkEnemy1":
		damageTaken = 10
		receivingDamage = true

func _on_PlayersDamageArea_area_exited(area):
	receivingDamage = false
