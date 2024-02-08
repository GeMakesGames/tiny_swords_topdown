extends Area2D
class_name Wood

@onready var spr = $AnimatedSprite2D

func _ready():
	spr.play("spawn")
