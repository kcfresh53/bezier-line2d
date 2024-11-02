@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type("BezierLine2D", "Path2D", preload("res://addons/bezier-line-2d/bezier_line2d.gd"), preload("res://addons/bezier-line-2d/icon.svg"))


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("BezierLine2D")
