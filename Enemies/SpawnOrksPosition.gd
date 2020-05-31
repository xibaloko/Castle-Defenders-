extends Position2D

onready var orkReference1 = load ("res://Enemies/OrkEnemy1.tscn")

var waveCount = 0
var wavesQuantity = 3
var wavesInterval = 10
var orksCount = 0
var orksQuantity = 3
var orksSpawnInterval = 2

func _ready():
	$WaveTimer.set_wait_time(wavesInterval)
	$WaveTimer.start()

func _on_WaveTimer_timeout():
	print("Começou a wave")
	if waveCount < wavesQuantity:
		$IntervalTimer.set_wait_time(orksSpawnInterval)
		$IntervalTimer.start()
		
		print("Começou os monstros")
	else:
		$WaveTimer.stop()
		print("parou a wave")
	

func _on_IntervalTimer_timeout():
	print("começou os monstros")
	if orksCount < orksQuantity:
		var spawnInstance = orkReference1.instance()
	
		get_parent().add_child(spawnInstance)
		spawnInstance.set_global_position(get_global_position())
		orksCount += 1
		print("instanciou")
	else:
		$IntervalTimer.stop()
		waveCount += 1
		orksCount = 0
		print("parou os monstros")
