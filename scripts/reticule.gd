class_name Reticule
extends Control

@export var dot_size: float = 2.0
@export var dot_color: Color = Color.WHITE_SMOKE

func _draw() -> void:
	draw_circle(Vector2.ZERO, dot_size, dot_color)

func update_color(new_color: Color):
	if dot_color != new_color:
		dot_color = new_color
		queue_redraw()
