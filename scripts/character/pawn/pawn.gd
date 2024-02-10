extends CharacterBody2D

@onready var fsm = $FSM
@onready var spr = $AnimatedSprite2D
@onready var input := InputManager.new()
@onready var carry_container = $CarryContainer

#############################
# Carrying logic
var carrying := false:
	get: return carrying
	set(value):
		carrying = value
		for r in r_in_rng:
			r.set_hl(not value)
			
var carry_obj :
	get: return carry_obj
	set(value):
		carry_obj = value
		carrying = value != null

var carry_queue = []
var carry_target = null :
	get: return carry_target
	set(value):
		if carry_target == value: return
		if carry_target:
			carry_target.set_hl(false)
		carry_target = value
		if value:
			carry_target.set_hl(true)

func pick_up():
	if not carry_target: return
	if carry_obj:
		carry_obj.stack(carry_target)
		select_next_carry_target(true)
		return
	
	carry_obj = carry_target
	select_next_carry_target(true)
	carry_obj.reparent(carry_container)
	carry_obj.pick_up()
	carry_obj.global_position = carry_container.global_position
	
func drop():
	if not carry_obj: return
	carry_obj.reparent(get_parent())
	carry_obj.drop()
	carry_obj = null

func select_next_carry_target(override := false):
	if override: carry_target = null
	if not override and carry_target: return
	if carrying:
		carry_target = carry_queue.filter(filter_target_by_carry_obj_type).pop_front()
		if carry_target: carry_queue.erase(carry_target)
	else:
		carry_target = carry_queue.pop_front()

func filter_target_by_carry_obj_type(target):
	return target.type == carry_obj.type
	
#############################
		
const BASE_MAX_SPD = Vector2(90, 90)
const BASE_ACCEL = 900

var r_in_rng = []

var f_dir := 1 :
	get: return f_dir
	set(value):
		if not value or value == 0: return
		spr.flip_h = value == -1
		carry_container.scale.x = value
		f_dir = value

func _ready():
	fsm.change_state("idle")

func _physics_process(delta : float):
	input.update(delta)
	fsm.physics_update(delta)

func play(anim : String):
	spr.play(anim)

func _on_chop_area_area_entered(hitbox):
	var r = hitbox.get_parent()
	r.set_hl(not carrying)
	r_in_rng.append(r)
	

func _on_chop_area_area_exited(hitbox):
	var r = hitbox.get_parent()
	r.set_hl(false)
	r_in_rng.erase(r)

func _on_collect_area_area_entered(collectable):
	if collectable == carry_target or collectable == carry_obj: return
	carry_queue.append(collectable)
	select_next_carry_target()

func _on_collect_area_area_exited(collectable):
	if carry_target == collectable:
		carry_target = null
	carry_queue.erase(collectable)
	select_next_carry_target()
