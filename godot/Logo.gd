extends Sprite2D

var left = true


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(self.position.x < 100):
		left = false
	if(self.position.x > 800):
		left = true
	if(left):
		self.move_local_x(-1.6)
	if(not left):
		self.move_local_x(1.6)
