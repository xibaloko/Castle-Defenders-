extends Position2D

signal AllOrksDied

onready var orkReference = load ("res://Enemies/OrkEnemy3.tscn")

var spawnInstance

var waveCount = 0
var wavesQuantity = 5
var wavesInterval = 10
var orksCount = 0
var orksQuantity = 3
var orksSpawnInterval = 2

func _ready():
	spawnInstance = orkReference.instance()
	$WaveTimer.set_wait_time(wavesInterval)
	$WaveTimer.start()
	
func _process(_delta):
	if waveCount == wavesQuantity and not is_instance_valid(spawnInstance):
		emit_signal("AllOrksDied")
		self.queue_free()

func _on_WaveTimer_timeout():
	if waveCount < wavesQuantity:
		$IntervalTimer.set_wait_time(orksSpawnInterval)
		$IntervalTimer.start()
	else:
		$WaveTimer.stop()

func _on_IntervalTimer_timeout():
	if orksCount < orksQuantity:
		spawnInstance = orkReference.instance()
		get_parent().add_child(spawnInstance)
		spawnInstance.set_global_position(get_global_position())
		orksCount += 1
	else:
		$IntervalTimer.stop()
		waveCount += 1
		orksCount = 0
