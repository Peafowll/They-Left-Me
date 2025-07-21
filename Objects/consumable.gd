class_name Consumable
extends Resource
@export var name : String
@export var food_fill : float
@export var thirst_fill : float
@export var sanity_fill : float
@export var energy_fill : float
@export_multiline var description : String
@export_enum("food","drink") var type : String
@export var rarity : float = 10
