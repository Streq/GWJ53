extends Timer

func start_if_not_started():
	if is_stopped():
		start()
