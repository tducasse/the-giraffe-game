extends RigidBody2D

onready var ItemSprite = $Sprite

var type = null
var food = preload("res://food.png")
var bad = preload("res://bad.png")

signal item_picked(type)


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
	emit_signal("item_picked", type)
	queue_free()
