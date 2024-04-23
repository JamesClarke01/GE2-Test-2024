@tool
extends Node3D

@export var length: float = 20
@export var frequency: float = 1
@export var startAngle: float = 0
@export var baseSize: float = 1
@export var multiplier: float = 5

"""
func drawCreatureGizmos():
	var boxPos = global_transform.origin

	for i in length:
		var sine = sin(remap(i, 0, length, 0, 2*PI))
		var boxSize = baseSize * remap(sine, 0, 1, 0, multiplier)
		boxPos.x -= boxSize/2
		DebugDraw3D.draw_box(boxPos, Quaternion.IDENTITY, Vector3(boxSize,boxSize,boxSize), Color.CHARTREUSE, true)
		boxPos.x -= boxSize/2
"""

func drawCreatureGizmos():
	var boxPos = global_transform.origin
	
	#Note: Couldn't figure out how to return a value from sine function so had to hardcode an array of values
	#My attempt is in the commented out function

	var sineArray = [0, 0.2, 0.4, 0.6,0.8,1 ,0.8,0.6,0.4,0.2,0] 
	for sine in sineArray:
		var boxSize = baseSize * remap(sine, 0, 1, 0, multiplier)
		boxPos.x -= boxSize/2
		DebugDraw3D.draw_box(boxPos, Quaternion.IDENTITY, Vector3(boxSize,boxSize,boxSize), Color.CHARTREUSE, true)
		boxPos.x -= boxSize/2

func createCreature():
	var boxPos = global_transform.origin

	var sineArray = [0, 0.2, 0.4, 0.6,0.8,1 ,0.8,0.6,0.4,0.2,0] 
	for sine in sineArray:
		var boxSize = baseSize * remap(sine, 0, 1, 0, multiplier)
		boxPos.x -= boxSize/2		
		var bodyPart = CSGBox3D.new()
		bodyPart.transform.origin = boxPos
		bodyPart.size = Vector3(boxSize, boxSize, boxSize)
		add_child(bodyPart)
		boxPos.x -= boxSize/2


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint():		
		#drawCreatureGizmos()
		drawCreatureGizmos()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#drawCreatureGizmos()
	createCreature()
	#testDraw()
	#drawCreatureGizmos()
