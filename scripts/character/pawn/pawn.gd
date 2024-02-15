extends CharacterBody2D

@onready var fsm = $FSM
@onready var spr = $AnimatedSprite2D
@onready var input := InputManager.new()
@onready var carry_container = $CarryContainer
@onready var attack_area = $AttackArea
@onready var interact_area = $InteractArea

#############################
# Carrying logic
var carrying := false:
	get: return carrying
	set(value):
		carrying = value
		attack_area.hl = not value
			
var carry_obj :
	get: return carry_obj
	set(value):
		carry_obj = value
		carrying = value != null

func carry(target):
	if carry_obj:
		carry_obj.stack(target)
		interact_area.next_target(false)
		return
	
	carry_obj = target
	interact_area.filter = filter_target_by_carry_obj_type
	interact_area.next_target(false)
	carry_obj.reparent(carry_container)
	carry_obj.global_position = carry_container.global_position
	
func filter_target_by_carry_obj_type(target):
	if not target or not "type" in target: return false
	return target.type == carry_obj.type

func drop():
	if not carry_obj: return
	carry_obj.reparent(get_parent())
	carry_obj.drop()
	interact_area.filter = null
	carry_obj = null
#############################
		
const BASE_MAX_SPD = Vector2(90, 90)
const BASE_ACCEL = 900

var f_dir := 1 :
	get: return f_dir
	set(value):
		if not value or value == 0: return
		spr.flip_h = value == -1
		carry_container.scale.x = value
		f_dir = value

func _ready():
	carrying = false
	fsm.change_state("idle")

func _physics_process(delta : float):
	input.update(delta)
	fsm.physics_update(delta)

func play(anim : String):
	spr.play(anim)

func interact():
	if interact_area.has_target():
		interact_area.target.interact(self)
