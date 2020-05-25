extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const SPEED = 50
const JUMP_HEIGHT = -300

var life = 50
var energy = 50

var motion = Vector2()

func _ready():
	var lifeBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("PlayerStats").get_node("PlayersLifeBar")
	var energyBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("PlayerStats").get_node("PlayersEnergyBar")
	lifeBar.set_value(life)
	energyBar.set_value(energy)
	
func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$AnimatedSprite.play("Running")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$AnimatedSprite.play("Running")
		$AnimatedSprite.flip_h = true
	else:
		motion.x = 0
		$AnimatedSprite.play("Idle")
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	
	motion = move_and_slide(motion, UP)
