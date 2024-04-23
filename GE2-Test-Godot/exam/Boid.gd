extends CharacterBody3D

@export var mass = 1
@export var force = Vector3.ZERO
@export var acceleration = Vector3.ZERO
@export var vel = Vector3.ZERO
@export var speed:float
@export var max_speed: float = 10.0
@export var frequency = 0.3
@export var damping = 0.1

@export var theta = 0
@export var amplitude = 80
@export var distance = 5
var world_target:Vector3
var target:Vector3
@export var radius = 10.0

enum Axis { Horizontal, Vertical}
@export var axis = Axis.Horizontal

var noise:FastNoiseLite = FastNoiseLite.new()

func _ready():
	noise.seed = randi()
	noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	noise.set_frequency(0.01)
	noise.set_fractal_lacunarity(2)
	noise.set_fractal_gain(0.5)

func calculateNoiseWanderForce():
	var n  = noise.get_noise_1d(theta)
	var angle = deg_to_rad(n * amplitude)
	
	var delta = get_process_delta_time()

	var rot = global_transform.basis.get_euler()
	rot.x = 0
	

	if axis == Axis.Horizontal:
		target.x = sin(angle)
		target.z =  cos(angle)
		target.y = 0
		rot.z = 0
	else:
		target.y = sin(angle)
		target.z = cos(angle)
		target.x = 0
		
	target *= radius

	var local_target = target + (Vector3.BACK * distance)
	
	var projected = Basis.from_euler(rot)
	
	world_target =global_transform.origin + (projected * local_target)	
	theta += frequency * delta * PI * 2.0
	
	var toTarget = world_target - global_transform.origin
	toTarget = toTarget.normalized()
	var desired = toTarget * max_speed
	return desired - vel

	


func _physics_process(delta):
	force = calculateNoiseWanderForce()
	acceleration = force / mass
	vel += acceleration * delta
	speed = vel.length()
	if speed > 0:		
		if max_speed == 0:
			print("max_speed is 0")
		vel = vel.limit_length(max_speed)
		
		# Damping
		vel -= vel * delta * damping
		
		set_velocity(vel)
		move_and_slide()
		

