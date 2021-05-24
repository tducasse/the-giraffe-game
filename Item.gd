extends RigidBody2D


func _on_Area2D_body_entered(_body):
	# depending on what the current item is,
	# send a signal to the game manager
	# and then destroy the object
	queue_free()
