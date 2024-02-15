extends Area2D

var hl := true :
	get: return hl
	set(value):
		if hl == value: return
		hl = value
		if target:
			target.hl = value
			
var queue = []

var target :
	get: return target
	set(value):
		if target == value: return
		if target:
			target.hl = false
		target = value
		if value:
			target.hl = hl

var filter:
	get: return filter
	set(value):
		filter = value
		if not value: return
		next_target(filter.call(target))

func next_target(keep_current := false):
	if keep_current and target: return
	var filtered = queue.filter(filter) if filter else queue
	if target:
		filtered.erase(target)
	target = filtered.front() if not filtered.is_empty() else null

func has_target():
	return target != null

func _on_area_entered(area):
	if area is InteractableArea:
		area = area.interactable
	queue.append(area)
	next_target(true)

func _on_area_exited(area):
	if area is InteractableArea:
		area = area.interactable
	queue.erase(area)
	next_target(area != target)
