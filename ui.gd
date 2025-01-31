extends Node

enum UI_STATE {
	PAUSE,
	GAME_START,
	GAME,
	MENU
}

enum UI_TRANSITION {
	PAUSE,
	UNPAUSE,
	START_GAME,
	EXIT_GAME
}


var state = UI_STATE.GAME_START

@onready var HUD =  $CanvasLayer/HUD
@onready var StartMenu = $CanvasLayer/StartMenu
@onready var World = $"../World"

signal change_ui(transition)

func _ready():
	get_tree().paused = true
	World.visible = false
	HUD.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		get_tree().paused = true


func _on_start_game_pressed():
	change_ui.emit(UI_TRANSITION.START_GAME)

func on_state_enter():
	match state:
		UI_STATE.GAME:
			World.visible = true
			HUD.visible = true
			get_tree().paused = false
		UI_STATE.GAME_START,UI_STATE.PAUSE, UI_STATE.MENU:
			get_tree().paused = true
			World.visible = false
			HUD.visible = false
			

func _on_change_ui(transition):
	match transition:
		UI_TRANSITION.UNPAUSE:
			state = UI_STATE.GAME
		UI_TRANSITION.START_GAME:
			state = UI_STATE.GAME
		UI_TRANSITION.PAUSE:
			state = UI_STATE.MENU
	on_state_enter()
