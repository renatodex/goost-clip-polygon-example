extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
		# Hide initial polygons
	$EdgeTop.hide()
	$EdgeBottom.hide()
	$EdgeRight.hide()
	$EdgeLeft.hide()
	
	# 1. Set MergedPolygon to be equal to Top Polygon
	$MergedPolygon.set_polygon($EdgeTop.polygon)
	
	# Wait 1 second
	yield(get_tree().create_timer(1.0), "timeout")
	
	# 2. Merge MergedPolygon with Right Polygon
	var merge1 = GoostGeometry2D.merge_polygons(
		$MergedPolygon.polygon,
		$EdgeRight.polygon
	)
	$MergedPolygon.set_polygon(merge1[0])
	
	# Wait 1 second
	yield(get_tree().create_timer(1.0), "timeout")
	
	# 3. Merge MergedPolygon with Bottom Polygon
	var merge2 = GoostGeometry2D.merge_polygons(
		$MergedPolygon.polygon,
		$EdgeBottom.polygon
	)
	$MergedPolygon.set_polygon(merge2[0])
	
	# Wait 1 second
	yield(get_tree().create_timer(1.0), "timeout")
	
	# 4. Merge MergedPolygon with Left Polygon
	# This close the area, leaving a hole in the middle
	var merge3 = GoostGeometry2D.merge_polygons(
		$MergedPolygon.polygon,
		$EdgeLeft.polygon
	)
	
	# Inspecting the last merge, it seems 2 polygons are returned
	# The first seems to be the boundary polygon
	# and the second is the hole polygon.
	print(merge3)
	
	# You will see that instead of keeping the gap, this
	# closes the polygon.
	# Of course i should somehow consider the second polygon
	# to draw the end polygon, but i have no idea how to do that.
	$MergedPolygon.set_polygon(merge3[0])
