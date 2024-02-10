extends State

@onready var destroyed_tex = preload("res://assets/buildings/house/house_destroyed.png")

func enter():
	obj.spr.texture = destroyed_tex

