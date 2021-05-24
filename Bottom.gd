extends Area2D


func _on_Bottom_body_entered(body):
	body.queue_free()
