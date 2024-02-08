extends State

func enter():
	obj.play("cut")
	obj.hbox_col.set_deferred("disabled", true)
	spawn_wood()

func spawn_wood():
	var w = obj.wood_res.instantiate()
	w.global_position = obj.global_position + Vector2(randi_range(15, 40), randi_range(15, 40))
	obj.add_sibling(w)
