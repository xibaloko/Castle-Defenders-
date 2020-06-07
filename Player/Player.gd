extends KinematicBody2D

onready var orkReference1 = load ("res://Enemies/OrkEnemy1.tscn")

signal CallTroops

const UP = Vector2(0, -1)
const GRAVITY = 15
const SPEED = 50
const JUMP_HEIGHT = -300

var life = 2500
var energy = 100

var isAttacking = false
var receivingDamage = false
var damageTaken
var availableEnergy = true
var energyCost = 25

var col

var motion = Vector2()

func damage():
	life -= damageTaken

func spendEnergy():
	if energy > 0:
		energy -= energyCost
		emit_signal("CallTroops")
	else:
		availableEnergy = false

func updateLifeAndEnergyBar():
	var lifeBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("PlayerStats").get_node("PlayersLifeBar")
	var energyBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("PlayerStats").get_node("PlayersEnergyBar")
	lifeBar.set_value(life)
	energyBar.set_value(energy)

func _physics_process(_delta):
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
	if Input.is_action_just_pressed("Call Troop"):
		if availableEnergy:
			spendEnergy()
			print(energy)
	
	motion = move_and_slide(motion, UP)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attacking":
		$AttackArea/CollisionShape2D.disabled = true
		isAttacking = false

func _on_PlayersDamageArea_area_entered(area):
	if area.is_in_group("OrkEnemy1"):
		damageTaken = 10
		receivingDamage = true

func _on_PlayersDamageArea_area_exited(_area):
	receivingDamage = false

func _on_OrkEnemy1_orcDead():
	receivingDamage = false
