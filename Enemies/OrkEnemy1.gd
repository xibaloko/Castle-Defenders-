extends KinematicBody2D

signal orcDead

onready var deathSound = get_node("DeathSound")
onready var hitSound = get_node("HitSound")

var player
var dead = false
var speed = 50
var walking = true
var killingHits = 1

var life = 1300
var damageTaken
var receivingDamage = false

func damage():
	if life > 0:
		life -= damageTaken
	else:
		dead = true
		deathSound.play()

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("Running")
	self.connect("orcDead", player, "_on_OrkEnemy1_orcDead")

func _process(delta):
	var castle = get_tree().get_root().get_node("Main").get_node("Castle")
	var dir = (castle.global_position - global_position).normalized()
	var col
	
	if receivingDamage == true:
		damage()
	
	if walking:
		col = move_and_collide(dir*speed*delta)
	
	if dead:
		$AnimatedSprite.play("Dying")
	else:
		if col and col.collider.name == "Player":
			$AnimatedSprite.play("Attacking")
		elif col && col.collider.name == "Castle":
			$AnimatedSprite.play("Attacking")
		elif col && col.collider.is_in_group("Troop"):
			$AnimatedSprite.play("Attacking")
		else:
			$AnimatedSprite.play("Running")
	
func _on_DyingActionArea_area_entered(area):
	if area.is_in_group("Sword"):
		killingHits -= 1
		hitSound.play()
		if killingHits == 0:
			add_collision_exception_with(get_tree().get_root().get_node("Main").get_node("Player"))
			dead = true
			deathSound.play()
			emit_signal("orcDead")
			walking = false
	if area.is_in_group("Troop"):
		damageTaken = 10
		receivingDamage = true

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dying":
		self.disconnect("orcDead", player, "_on_OrkEnemy1_orcDead")
		queue_free()

func _on_DyingActionArea_area_exited(_area):
	receivingDamage = false
