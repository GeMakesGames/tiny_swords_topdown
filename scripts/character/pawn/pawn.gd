extends CharacterBody2D

@onready var fsm = $FSM
@onready var spr = $AnimatedSprite2D
@onready var input := InputManager.new()
@onready var w_carry_cont = $WoodCarryContainer
@onready var w_c1 = $WoodCarryContainer/Slot1

var carry := false
var carry_objs = []

const BASE_MAX_SPD = Vector2(90, 90)
const BASE_ACCEL = 900

var c_queue = []
var c = null
var r_in_rng = []

var f_dir := 1 :
	get: return f_dir
	set(value):
		if not value or value == 0: return
		spr.flip_h = value == -1
		f_dir = value

func _ready():
	fsm.change_state("idle")

func _physics_process(delta : float):
	input.update(delta)
	fsm.physics_update(delta)

func play(anim : String):
	spr.play(anim)

func pick_up():
	c.reparent(w_carry_cont)
	c.global_position = w_c1.global_position

func _on_chop_area_area_entered(hitbox):
	var r = hitbox.get_parent()
	r.set_hl(true)
	r_in_rng.append(r)
	

func _on_chop_area_area_exited(hitbox):
	var r = hitbox.get_parent()
	r.set_hl(false)
	r_in_rng.erase(r)

func _on_collect_area_area_entered(collectable):
	if not c:
		c = collectable
		return
	c_queue.append(collectable)

func _on_collect_area_area_exited(collectable):
	if c == collectable:
		c = c_queue.pop_front()
		return
	c_queue.erase(collectable)
