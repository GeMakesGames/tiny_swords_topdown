extends Area2D

var hl := false:
	get: return hl
	set(value):
		if hl == value: return
		hl = value
		for target in targets:
			target.hl = value
			
var targets = []

func _on_area_entered(area):
	var t = area.get_parent()
	t.hl = hl
	targets.append(t)

func _on_area_exited(area):
	var t = area.get_parent()
	t.hl = false
	targets.erase(t)

func has_targets():
	return not targets.is_empty()
