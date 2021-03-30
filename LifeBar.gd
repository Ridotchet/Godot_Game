extends HBoxContainer

var maximum_value = 30

func initialize(maximum):
	maximum_value = maximum
	$TextureProgress.max_value = maximum

func _on_Interface_health_changed(health):
	$TextureProgress.value = health
	$Count/Number.text = "%s / %s" % [health, maximum_value]
