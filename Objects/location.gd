class_name Location
extends Resource
@export var name : String
@export var background_image : String #replace
@export var background_noise : String #replace this
@export var size : int
@export_range(1,100) var no_loot_chance : int
@export var loot_table : LootTable
