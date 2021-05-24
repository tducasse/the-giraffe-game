extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 1700


func _process(_delta):
	process_move()


func process_move():
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0
	)
	move(input_vector)


func move(value):
	velocity = move_and_slide(value * speed)
