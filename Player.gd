extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 1700
var neck_size = null
var origin_y = null

onready var Neck = $Neck

signal end_game()


func _ready():
	neck_size = Neck.rect_size.y
	origin_y = position.y

func _process(_delta):
	process_move()


func process_move():
	position = Vector2(get_viewport().get_mouse_position().x, position.y)


func add_neck():
	Neck.rect_size.y = Neck.rect_size.y + neck_size *2
	position.y = position.y - neck_size * 2
	

func remove_neck():
	Neck.rect_size.y = Neck.rect_size.y - neck_size * 2
	position.y = position.y + neck_size * 2


func shrink():
	if position.y < origin_y:
		remove_neck()
	else:
		emit_signal("end_game")
