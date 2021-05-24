extends Node2D

var Item = preload("res://Item.tscn")

var MARGIN = 200


func _ready():
	randomize()


func spawn_random_item():
	var random = randi() % (int(get_viewport_rect().size.x) - MARGIN)
	var item = Item.instance()
	# randomise item good/bad
	# randomise timeout
	item.position = Vector2(random + MARGIN / 2, 0)
	add_child(item)


func _on_Timer_timeout():
	spawn_random_item()
