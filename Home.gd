extends Control


func play():
	var _change = get_tree().change_scene("res://Game.tscn")


func _on_Play_pressed():
	play()
