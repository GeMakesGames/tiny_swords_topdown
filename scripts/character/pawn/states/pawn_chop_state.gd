extends State

func enter():
	obj.play("chop")
	obj.spr.animation_finished.connect(_on_chop_anim_finished)
	for r in obj.r_in_rng:
		r.hit()

func _on_chop_anim_finished():
	change_state("idle")

func exit():
	obj.spr.animation_finished.disconnect(_on_chop_anim_finished)
