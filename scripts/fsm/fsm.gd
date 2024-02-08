extends Node
class_name FSM

var sts = {}
var cur_st
var prev_st
var cur_st_node : State

func _ready():
	var obj = get_parent()
	for child in get_children():
		if child is State:
			child.obj = obj
			child.fsm = self
			sts[child.name.to_lower()] = child

func update(delta : float):
	if not cur_st_node: return
	cur_st_node.update(delta)

func physics_update(delta: float):
	if not cur_st_node: return
	cur_st_node.physics_update(delta)
	
func change_state(nxt_state):
	if cur_st_node:
		cur_st_node.exit()
	prev_st = cur_st
	cur_st = nxt_state
	cur_st_node = sts[cur_st]
	cur_st_node.enter()
