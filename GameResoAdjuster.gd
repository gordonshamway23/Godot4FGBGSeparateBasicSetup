extends Node

# This script automatically adjust the game subviewport size
# to be as large as the window resolution.
# It also changes the scale of "GameScene"
# in order to render everything at correct place.
# Looks like magic, but it's working.
# IMPORTANT: GameTextureRect expand mode must be "ignore size".
# NOTE: The script only make sense when "canvas_item" stretch mode
# is used in project settings.
# Feel free to copy paste this.

# resolution your game is designed in
@export var design_resolution : Vector2 = Vector2(320, 180)

@onready var game_sub_viewport : Viewport = $"../GameSubViewport"
@onready var game_scene = $"../GameSubViewport/GameScene"


func _ready():
	get_tree().root.size_changed.connect(_on_screen_size_changed)
	_on_screen_size_changed()
	
func _on_screen_size_changed():
	var vp : Viewport = get_viewport()
	if vp:
		var as_design : float = design_resolution.x / design_resolution.y
		var as_vp : float = vp.size.x / vp.size.y
		var game_vp_res : Vector2 = Vector2.ZERO
		if as_vp > as_design:
			game_vp_res.x = vp.size.y * as_design
			game_vp_res.y = vp.size.y
		else:
			game_vp_res.x = vp.size.x
			game_vp_res.y = vp.size.x / as_design
		
		game_sub_viewport.size = game_vp_res
		game_scene.scale = Vector2(game_vp_res.x / design_resolution.x,
			game_vp_res.y / design_resolution.y)
		#print("Window resized. Wnd size:", vp.size, "  Game viewport size:", game_vp_res)
