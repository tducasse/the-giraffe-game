extends Node2D


onready var Growth = $Growth
onready var Player = $Player

var HP_LOSS = 30
var HP_GAIN = 50


func _ready():
	pass


func _on_Spawner_item_picked(type):
	if type == "bad":
		lose_hp()
	elif type == "food":
		gain_hp()


func lose_hp():
	Growth.value = max(0, Growth.value - HP_LOSS)
	if Growth.value == 0:
		shrink()


func gain_hp():
	Growth.value = min(100, Growth.value + HP_GAIN)
	if Growth.value == 100:
		grow()
		Growth.value = 0


func grow():
	Player.add_neck()


func shrink():
	Player.shrink()


func _on_Player_end_game():
	print("lost_game")


func _on_Goal_item_picked(type):
	print("win game")
