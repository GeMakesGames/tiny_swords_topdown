extends Area2D

var hl := true :
	get: return hl
	set(value):
		if hl == value: return
		hl = value
		if interact_target:
			interact_target.hl = value
			
var interact_queue = []

var interact_target :
	get: return interact_target
	set(value):
		if interact_target == value: return
		if interact_target:
			interact_target.hl = false
		interact_target = value
		if value:
			interact_target.hl = hl

var interact_filter:
	get: return interact_filter
	set(value):
		interact_filter = value
		if not value: return
		next_target(interact_filter.call(interact_target))

func next_target(keep_current := false):
	if keep_current and interact_target: return
	var filtered = interact_queue.filter(interact_filter) if interact_filter else interact_queue
	interact_target = filtered.front()


func _on_area_entered(area):
	interact_queue.append(area)
	next_target(true)

func _on_area_exited(area):
	interact_queue.erase(area)
	next_target(area != interact_target)
