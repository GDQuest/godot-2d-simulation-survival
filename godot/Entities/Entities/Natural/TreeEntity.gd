extends Entity

const REGIONS := [
	Rect2(10, 560, 210, 210),
	Rect2(230, 560, 210, 210),
	Rect2(450, 560, 210, 210),
	Rect2(670, 560, 210, 210),
]


func _ready() -> void:
	$Foliage.region_rect = REGIONS[int(rand_range(0, REGIONS.size() - 1))]
	$Foliage.flip_h = rand_range(0, 10) < 5.5


func _get_pickup_count() -> int:
	return 5
