extends Area3D

@export var shake_amt := 0.1

func cause_shake():
	var trauma_areas := get_overlapping_areas()
	for area in trauma_areas:
		if area.has_method("cause_shake"):
			area.cause_shake(shake_amt)
