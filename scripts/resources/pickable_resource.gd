extends Area2D
class_name PickableResource

@onready var col = $CollisionShape2D 
@onready var stack_col = $StackArea/CollisionShape2D
@onready var hl = $Highlight
@export_enum("Wood", "Gold", "Meat") var type

#Amount logic
var sprs = []

var picked = false

var amount := 1 :
	get: return amount
	set(value):
		upt_vis_spr(value)
		if amount < sprs.size() and value > amount:
			play_vis_spr("spawn")
		amount = value
		
var stack_queue_request

func play_vis_spr(anim):
	for s in sprs:
		if s.visible: s.play(anim)

func upt_vis_spr(amt):
	amt = clampi(amt, 0, sprs.size())
	for i in sprs.size():
		sprs[i].visible = i < amt
		
func stack(other):
	amount += other.amount
	other.queue_free()
#######################

func _ready():
	for child in $SpriteContainer.get_children():
		if child is AnimatedSprite2D:
			sprs.append(child)
	upt_vis_spr(amount)
	play_vis_spr("spawn")

func pick_up():
	if picked: return
	col.set_deferred("disabled", true)
	stack_col.set_deferred("disabled", true)
	picked = true

func drop():
	if not picked: return
	col.set_deferred("disabled", false)
	stack_col.set_deferred("disabled", false)
	picked = false
	play_vis_spr("idle")

func set_hl(b : bool):
	hl.visible = b

func _on_stack_area_area_entered(area):
	var other = area.get_parent()
	if other.type != type: return
	if other.amount > amount: return
	if other.amount < amount: 
		amount += other.amount
		other.queue_free()
		return
	if stack_queue_request:
		stack_queue_request = null
		amount += other.amount
		other.queue_free()
	else:
		other.stack_queue_request = self
