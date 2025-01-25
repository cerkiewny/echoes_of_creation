extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -630.0
const MAX_COYOTEE = 0.05
const FALLING_FACTOR = 1.9
const JUMP_WILLPOWER = 0.08
const DELAYED_JUMP_FACTOR = 0.1


signal take_dmg

var last_safe_position
var player
@onready var coyotee_timer = MAX_COYOTEE
@onready var sprite_2d = $Sprite2D
@onready var wants_to_jump = false
@onready var since_last_jump = DELAYED_JUMP_FACTOR
var life = 5
var max_life = 5
    
func _ready():
    player = get_parent().get_node("Player")
    last_safe_position = player.global_position
    sprite_2d.animation = "idle"
    Engine.max_fps = 30


func is_on_floor_with_coyotee(delta):
    if (is_on_floor()):
        coyotee_timer = MAX_COYOTEE
    else:
        coyotee_timer -= delta
    return coyotee_timer >= 0.0

func hurt(dmg):
    life -= dmg
    take_dmg.emit()
    if(life <= 0):
        die()
    
func die():
    get_tree().reload_current_scene()
    
func set_animation():
    # Add the gravity.
    if(!is_on_floor()):
        sprite_2d.animation = "jump"
    elif (abs(velocity.x) > 0.0):
        sprite_2d.animation = "running"
    else:
        sprite_2d.animation = "idle"

func _physics_process(delta):
    if not is_on_floor_with_coyotee(delta):
        if(velocity.y > 0):
            velocity += get_gravity() * delta * FALLING_FACTOR
        else: 
            velocity += get_gravity() * delta * 1.3

    since_last_jump -= delta
        # Handle jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor_with_coyotee(delta):
        velocity.y = JUMP_VELOCITY
    elif wants_to_jump and since_last_jump >= 0 and is_on_floor_with_coyotee(delta):
        velocity.y = JUMP_VELOCITY
    elif Input.is_action_pressed("ui_accept") and velocity.y < 0 and not is_on_floor_with_coyotee(delta):
        velocity.y -= JUMP_WILLPOWER / delta
    
    if Input.is_action_just_pressed("ui_accept") and not is_on_floor_with_coyotee(delta):
        wants_to_jump = true
        since_last_jump = DELAYED_JUMP_FACTOR
        
    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction = Input.get_axis("ui_left", "ui_right")
    if direction:
        velocity.x = move_toward(velocity.x,direction *  SPEED, SPEED / 10)
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED / 10)
    set_animation()

    var isLeft = velocity.x < 0
    if (velocity.x != 0):
        sprite_2d.flip_h = isLeft
    move_and_slide()



func hurt_and_replace(dmg):
    hurt(1)
    player.global_position = last_safe_position
