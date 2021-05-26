extends Node2D


onready var Growth = $Growth

var HP_LOSS = 30
var HP_GAIN = 10


func _ready():
	pass


func _on_Spawner_item_picked(type):
	if type == "bad":
		lose_hp()
	elif type == "food":
		gain_hp()


func lose_hp():
	Growth.value = max(0, Growth.value - HP_LOSS)


func gain_hp():
	Growth.value = min(100, Growth.value + HP_GAIN)
	if Growth.value == 100:
		grow()


func grow():
	print("grow")
