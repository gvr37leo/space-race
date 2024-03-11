class_name Utils 

static func test():
	print("test")
	# You can add more static functions here

static func randVecInCircle() -> Vector2:
	var theta : float = randf() * 2 * PI
	return Vector2(cos(theta), sin(theta)) * sqrt(randf())

static func randVecInDonut(minradius,maxradius) -> Vector2:
	var theta : float = randf() * 2 * PI
	var point = Vector2(cos(theta), sin(theta)) * sqrt(randf_range(minradius/maxradius,1)) * maxradius
	return point
