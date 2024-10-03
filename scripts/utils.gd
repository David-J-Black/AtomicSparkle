extends Resource
class_name Utils

static func normalize_angle(angle: float) -> float:
	return wrapf(angle, 0, 2 * PI)
