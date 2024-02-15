extends State

@onready var construction_tex = preload("res://assets/buildings/house/house_construction.png")

func enter():
	obj.spr.texture = construction_tex

func interact(interactor):
	pass
