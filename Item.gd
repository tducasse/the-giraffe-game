extends RigidBody2D

onready var ItemSprite = $Sprite

var type = null
var food = preload("res://food.png")
var bad = preload("res://bad.png")


func init(type_param, speed_param):
	type = type_param
	gravity_scale = speed_param
	set_sprite()


func set_sprite():
	if type == "bad":
		ItemSprite.texture = bad
	elif type == "food":
		ItemSprite.texture = food


func _on_Area2D_body_entered(_body):
	# depending on what the current item is,
	# send a signal to the game manager
	# and then destroy the object
	queue_free()
