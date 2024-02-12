extends State

func enter():
	obj.play("chop")
	obj.spr.animation_finished.connect(_on_chop_anim_finished)
	for t in obj.attack_area.targets:
		t.hit()

func _on_chop_anim_finished():
	change_state("idle")

func exit():
	obj.spr.animation_finished.disconnect(_on_chop_anim_finished)
