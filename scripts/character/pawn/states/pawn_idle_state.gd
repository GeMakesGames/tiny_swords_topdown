extends State

func enter():
	obj.play("carry_idle" if obj.carry else "idle")

func physics_update(delta : float):
	obj.velocity = obj.velocity.move_toward(obj.BASE_MAX_SPD * obj.input.normalized, obj.BASE_ACCEL * delta)
	obj.move_and_slide()
	if obj.input.action:
		if obj.c:
			obj.carry = true
			enter()
			obj.pick_up()
		else:
			change_state("chop")
	elif obj.input.raw != Vector2.ZERO:
		change_state("run")
