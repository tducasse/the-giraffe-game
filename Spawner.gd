extends Node2D

var Item = preload("res://Item.tscn")
onready var Timer = $Timer

var MARGIN = 200

var MIN_SPAWN_TIME = 0.25
var MAX_SPAWN_TIME = 2
var MAX_SPEED = 6
var RATE_GOOD = 0.5

var rng = null

signal item_picked(type)


func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	start_timer()


func get_random_time():
	return rng.randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)


func get_random_speed():
	return rng.randf_range(1, MAX_SPEED)


func start_timer():
	Timer.start(get_random_time())


func get_random_position():
	var random = rng.randi() % (int(get_viewport_rect().size.x) - MARGIN)
	return Vector2(random + MARGIN / 2, 0)


func get_random_type():
	var random_float = rng.randf()
	if random_float < RATE_GOOD:
		return "food"
	else:
		return "bad"


func spawn_random_item():
	var item = Item.instance()
	item.position = get_random_position()
	add_child(item)
	item.init(get_random_type(), get_random_speed())
	item.connect("item_picked", self, "on_item_picked")


func on_item_picked(type):
	emit_signal("item_picked", type)


func _on_Timer_timeout():
	spawn_random_item()
	start_timer()
