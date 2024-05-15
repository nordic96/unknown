extends RigidBody3D

const JUMP_FORCE = 4

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

# Camera Nodes
@onready var twist_pivot = $TwistPivot
@onready var pitch_pivot = $TwistPivot/PitchPivot

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Player Movements (walking)
func handle_movement(delta):
	var input := Vector3.ZERO 
	input.x = Input.get_axis('move_left', 'move_right')
	input.z = Input.get_axis('move_forward', 'move_back')
	apply_central_force(twist_pivot.basis * input * 1200.0 * delta)
	if Input.is_action_pressed("jump"):
		self.apply_impulse(Vector3.UP * JUMP_FORCE)
		

func handle_camera_movement():
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, -0.5, 0.5)
	twist_input = 0
	pitch_input = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_camera_movement()
	handle_movement(delta)
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		twist_input = - event.relative.x * mouse_sensitivity
		pitch_input = - event.relative.y * mouse_sensitivity
		
