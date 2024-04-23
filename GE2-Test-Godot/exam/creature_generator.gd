@tool
extends Node3D

@export var length: float = 20
@export var frequency: float = 1
@export var startAngle: float = 0
@export var baseSize: float = 1
@export var multiplier: float = 5

func drawCreatureGizmos():		
	for i in range(length):
		var boxPos = global_transform.origin
		boxPos.x -= i * baseSize
		DebugDraw3D.draw_box(boxPos, Quaternion.IDENTITY, Vector3(baseSize,baseSize,baseSize), Color.CHARTREUSE, true)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():		
		drawCreatureGizmos()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drawCreatureGizmos()
