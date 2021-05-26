extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 1700


func _process(_delta):
	process_move()


func process_move():
	position = Vector2(get_viewport().get_mouse_position().x, position.y)
