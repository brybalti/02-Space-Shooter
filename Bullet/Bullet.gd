extends KinematicBody2D

export var velocity = Vector2(0,-8)
onready var Explosion = load("res://Explosion/Explosion.tscn")

func _ready():
	pass

func _physics_process(_delta):
	position += velocity
	
	if global_position.y < -100:
		queue_free()


func _on_Area2D_body_entered(body):
	body.queue_free()
	var explosion = Explosion.instance()
	explosion.position = position
	get_node("/root/Game/Explosions").add_child(explosion)
	queue_free()
