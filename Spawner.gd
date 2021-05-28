extends Node2D

var Item = preload("res://Item.tscn")
onready var Timer = $Timer

var MARGIN = 200

var MIN_SPAWN_TIME = 1
var MAX_SPEED = 4
var RATE_GOOD = 0.7
var current_spawn_time = 0
var current_speed = 0
var current_rate_good = 0

var rng = null

signal item_picked(type)


func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	start_timer()
	current_rate_good = get_current_rate_good(0)
	current_speed = get_current_speed(0)
	current_spawn_time = get_current_spawn_time(0)


func get_current_rate_good(level):
	return max(RATE_GOOD - level * 0.02, 0.5)


func get_current_speed(level):
	return min(MAX_SPEED + level * 2, 25)


func get_current_spawn_time(level):
	return max(MIN_SPAWN_TIME - level * 0.1, 0.05)


func get_random_time():
	return rng.randf_range(current_spawn_time, current_spawn_time + 0.7)


func get_random_speed():
	return rng.randf_range(current_speed-2, current_speed)


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


func level_up(level):
	current_rate_good = get_current_rate_good(level)
	current_speed = get_current_speed(level)
	current_spawn_time = get_current_spawn_time(level)
