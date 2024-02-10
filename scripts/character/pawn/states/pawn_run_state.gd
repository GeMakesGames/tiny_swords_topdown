extends State

func enter():
	obj.play("carry_run" if obj.carrying else "run")

func physics_update(delta):
	obj.velocity = obj.velocity.move_toward(obj.BASE_MAX_SPD * obj.input.normalized, obj.BASE_ACCEL * delta)
	obj.move_and_slide()
	obj.f_dir = obj.input.x
	
	if obj.input.interact:
		if obj.carry_target:
			obj.pick_up()
			enter()
		elif obj.carrying:
			obj.drop()
			enter()
	
	if obj.input.attack and not obj.carrying:
		change_state("chop")
	elif obj.input.raw == Vector2.ZERO:
		change_state("idle")
