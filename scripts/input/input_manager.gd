class_name InputManager

var normalized := Vector2.ZERO
var raw := Vector2.ZERO
var x := 0
var y := 0
var attack := false
var interact := false

func update(_delta: float):
	x = roundi(Input.get_axis("btn_left", "btn_right"))
	y = roundi(Input.get_axis("btn_up", "btn_down"))
	raw = Vector2(x, y)
	normalized = raw.normalized()
	attack = Input.is_action_just_pressed("btn_attack")
	interact = Input.is_action_just_pressed("btn_interact")
