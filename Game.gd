extends Node2D


onready var Growth = $Growth
onready var Player = $Player
onready var Score = $Score

onready var Music = $Music
onready var Lost = $Lost
onready var Win = $Win

onready var Hurt = $Hurt
onready var LevelUp = $LevelUp
onready var LevelDown = $LevelDown
onready var Pickup = $Pickup

onready var Spawner = $Spawner


var HP_LOSS = 30
var HP_GAIN = 50
var level = 0
var actual_level = 0


func _ready():
	Hurt.volume_db = -6
	Pickup.volume_db = -6
	LevelDown.volume_db = -6
	LevelUp.volume_db = -6
	Music.play()
	Win.pause_mode = Node.PAUSE_MODE_PROCESS
	Lost.pause_mode = Node.PAUSE_MODE_PROCESS


func _on_Spawner_item_picked(type):
	if type == "bad":
		lose_hp()
	elif type == "food":
		gain_hp()


func lose_hp():
	var loss = Growth.value - HP_LOSS
	if loss < 0:
		Growth.value = 100 + loss
		shrink()
	else:
		Growth.value = loss
		Hurt.play()
	Score.text = str(max(0, int(Score.text) - 10))


func gain_hp():
	Growth.value = min(100, Growth.value + HP_GAIN)
	if Growth.value == 100:
		grow()
		Growth.value = 0
	else:
		Pickup.play()
	Score.text = str(int(Score.text) + 10)
		


func grow():
	LevelUp.play()
	Player.add_neck()
	level_up()


func level_up():
	if level >= 10:
		return
	if level > actual_level:
		actual_level = actual_level + 1
		return
	level = level + 1
	actual_level = level
	HP_GAIN = max(HP_GAIN - level * 5, 10)
	Spawner.level_up(level)


func level_down():
	actual_level = actual_level -1


func shrink():
	level_down()
	LevelDown.play()
	Player.shrink()


func _on_Player_end_game():
	Growth.value = 0
	Music.stop()
	Lost.play()
	get_tree().paused = true


func _on_Goal_item_picked(_type):
	Music.stop()
	Win.play()
	get_tree().paused = true

