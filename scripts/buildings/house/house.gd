extends StaticBody2D

@onready var fsm = $FSM
@onready var spr = $Sprite2D
@onready var hl = $Highlight

func _ready():
	fsm.change_state("destroyed")

func _physics_process(delta):
	fsm.physics_update(delta)
