extends HBoxContainer

@onready var player = $"../../../../World/Player"
@onready var container = $"."
@onready var max_hp = player.max_life
@onready var heart = $"../Heart"
@onready var full_heart_texture =  preload("res://assets/player/heart.png")
@onready var depleated_heart_texture =  preload("res://assets/player/depleated_heart.png")

var heart_list : Array[TextureRect]


# Called when the node enters the scene tree for the first time.
func _ready():
    for i in range(max_hp):
        var new_heart = heart.duplicate()
        container.add_child(new_heart)
        new_heart.visible = true
    heart_list.append_array(container.get_children())


func _process(delta):
    pass


func _on_player_take_dmg():
    for i in range(player.life):
        heart_list[i].set_texture(full_heart_texture)
    for i in range (player.life, player.max_life):
        heart_list[i].set_texture(depleated_heart_texture)
