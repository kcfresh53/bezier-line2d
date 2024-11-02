@tool
extends Path2D

@export var width: float = 10.0:
	set(x):
		width = x
		queue_redraw()
@export var color: Color:
	set(x):
		color = x
		queue_redraw()
@export var antialiasing: bool = true:
	set(x):
		antialiasing = x
		queue_redraw()
@export var filled: bool = false:
	set(x):
		filled = x
		queue_redraw()
@export_enum("Squared", "Rounded") var caps: int:
	set(x):
		caps = x
		queue_redraw()


func _draw():
	# Get the Curve2D from the Path2D
	if curve == null:
		return
	
	# Get baked points for a smooth line along the curve
	var points = curve.get_baked_points()
	
	# Check if the shape is closed by comparing the first and last points
	var is_closed = points.size() > 2 and points[0].distance_to(points[points.size() - 1]) < 1e-4
	
	# Fill the shape if `filled` is true and the shape is closed
	if filled and is_closed:
		var color_array = PackedColorArray([color])
		draw_polygon(points, color_array)
	
	# Draw the path as a polyline
	draw_polyline(points, color, width, antialiasing)
	
	match caps:
		0:
			return
		1:
			# Add rounded caps by drawing circles at the start and end of the line
			if points.size() > 1:
				var radius = width / 2
				draw_circle(points[0], radius, color, true, -1.0, antialiasing)  # Start cap
				draw_circle(points[points.size() - 1], radius, color, true, -1.0, antialiasing)  # End cap
