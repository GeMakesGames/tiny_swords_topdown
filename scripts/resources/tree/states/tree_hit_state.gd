extends State

func enter():
	obj.play("hit")
	obj.spr.animation_finished.connect(_on_hit_anim_finished)

func _on_hit_anim_finished():
	if obj.hp <= 0:
		change_state("cut")
	else:
		change_state("idle")

func exit():
	obj.spr.animation_finished.disconnect(_on_hit_anim_finished)
