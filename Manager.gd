extends Node2D

var Win = null
var Lost = null

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	Win = get_parent().get_node("Win")
	Lost = get_parent().get_node("Lost")
	var _sig = Lost.connect("finished", self, 'back')
	var _sig2 = Win.connect("finished", self, 'back')


func back():
	get_tree().paused = false
	var _change = get_tree().change_scene("res://Home.tscn")
