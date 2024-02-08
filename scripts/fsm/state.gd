extends Node
class_name State

var obj
var fsm : FSM

func enter():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass

func exit():
	pass

func change_state(nxt_state : String):
	fsm.change_state(nxt_state)
