extends Node2D


@export var day : int = 0
@export var hour : float = 0


var Locations : Array[Location] = []

func _ready() -> void:
	Locations.append(load( "res://Resources/Locations/city.tres"))
	print(Locations[0].loot_table.pool[0].name)
