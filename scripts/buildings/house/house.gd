extends StaticBody2D

@onready var fsm = $FSM
@onready var spr = $Sprite2D
@onready var hl_container = $Highlight

var hl := false:
	get: return hl
	set(value):
		if value == hl: return
		hl = value
		hl_container.visible = value

func _ready():
	fsm.change_state("destroyed")

func _physics_process(delta):
	fsm.physics_update(delta)

func interact(interactor):
	fsm.cur_st_node.interact(interactor)
