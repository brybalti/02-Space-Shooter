extends KinematicBody2D

export var speed = 0.2
export var rotation_speed = 3
var velocity = Vector2(0,0)
var max_velocity = 4

onready var Bullet = load("res://Bullet/Bullet.tscn")
var reloaded = true

func _ready():
	pass

func _process(_delta):
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("left"):
		rotation_degrees -= rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees += rotation_speed
	if Input.is_action_pressed("up"):
		velocity += Vector2.UP.rotated(rotation)*speed

	var magnitude = velocity.length()
	magnitude = clamp(magnitude,0,max_velocity)
	velocity = Vector2.RIGHT.rotated(velocity.angle())*magnitude
	
	position += velocity
	
	position.x = clamp(position.x,0,1200)
	position.y = clamp(position.y,0,673)
	
	if Input.is_action_just_pressed("shoot") and reloaded:
		var bullet = Bullet.instance()
		bullet.position = position
		bullet.rotation = rotation
		bullet.velocity = bullet.velocity.rotated(rotation)
		get_node("/root/Game/Bullets").add_child(bullet)
		reloaded = false
		$Timer.start()

func get_input():
	var input_dir = Vector2(0,0)
	if Input.is_action_pressed("up"):
		input_dir.y -= 1
	if Input.is_action_pressed("down"):
		input_dir.y += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	return input_dir.rotated(rotation)


func _on_Timer_timeout():
	reloaded = true
