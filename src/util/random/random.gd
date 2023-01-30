class_name Random


static func choose_weighted(weights) -> int:
	var sum = 0.0
	for weight in weights:
		sum += weight
	
	var r = rand_range(0, sum)
	var i = 0
	while i < weights.size()-1:
		r -= weights[i]
		if r <= 0:
			break
		i += 1
	return i
