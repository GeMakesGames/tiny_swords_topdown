extends StaticBody2D

@onready var spr = $AnimatedSprite2D
@onready var fsm = $FSM
@onready var hl = $Highlight
@onready var hbox_col = $Hitbox/CollisionShape2D
@onready var wood_res = preload("res://scenes/resources/tree/pickable_wood.tscn")

var hp = 2

func _ready():
	fsm.change_state("idle")
	
func play(anim : String):
	spr.play(anim)

func hit():
	hp -= 1
	fsm.change_state("hit")

func set_hl(b : bool):
	hl.visible = b
