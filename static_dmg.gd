extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_2_body_entered(body):
	if body.has_method("hurt_and_replace"):
		body.hurt_and_replace(1)


func _on_body_entered(body):
	if body.has_method("hurt"):
		body.hurt(1) # Replace with function body.
