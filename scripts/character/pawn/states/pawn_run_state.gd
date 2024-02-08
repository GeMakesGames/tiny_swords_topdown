extends State

func enter():
	obj.play("carry_run" if obj.carry else "run")
	
func physics_update(delta):
	obj.velocity = obj.velocity.move_toward(obj.BASE_MAX_SPD * obj.input.normalized, obj.BASE_ACCEL * delta)
	obj.move_and_slide()
	obj.f_dir = obj.input.x
	if obj.input.raw == Vector2.ZERO:
		change_state("idle")
