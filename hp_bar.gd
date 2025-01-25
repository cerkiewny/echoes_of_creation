extends HBoxContainer

@onready var player = $"../../Player"
@onready var container = $"."
@onready var max_hp = player.max_life
@onready var heart = $"../TextureRect"
var heart_list : Array[TextureRect]


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(max_hp):
		container.add_child(heart.duplicate())
	heart_list.append_array(container.get_children())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_take_dmg():
	for i in range(heart_list.size()):
		heart_list[i].visible = i < player.life
	pass # Replace with function body.
