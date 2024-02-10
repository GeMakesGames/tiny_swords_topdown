extends State

func enter():
	obj.play("idle")
	obj.spr.animation_looped.connect(_on_idle_animation_looped)

func _on_idle_animation_looped():
	obj.spr.speed_scale = randf_range(.7, 1.3)
	
func exit():
	obj.spr.animation_looped.disconnect(_on_idle_animation_looped)
