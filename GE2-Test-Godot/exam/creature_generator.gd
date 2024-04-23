extends Node3D

@export var length: float = 20
@export var frequency: float = 1
@export var startAngle: float = 0
@export var baseSize: float = 1
@export var multiplier: float = 5

func drawCreatureGizmos():
	
	DebugDraw3D.draw_box(global_transform.origin,Quaternion.IDENTITY,Vector3(3,3,3), Color.DARK_GOLDENROD, true)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drawCreatureGizmos()
