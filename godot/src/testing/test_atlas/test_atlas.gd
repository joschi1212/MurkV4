extends Sprite2D

var atlas : AtlasTexture
var sprite : Sprite2D
var sprite_simple : Sprite2D
func _ready():
	var work_directory = "res://src/testing/test_atlas/"
	sprite = self
	sprite_simple = get_node("../Sprite2DImage")
	print(sprite_simple)
	atlas = load(work_directory + "atlas_test.tres")
	var atlas_image = atlas.get_image()
	atlas_image.save_jpg(work_directory)
	var sprite_image = sprite.get_texture().get_image()
	print(sprite_image.save_png("res://src/testing/test_atlas/bla3.png"))
	var sprite_simple_image = sprite_simple.get_texture().get_image()
	print(sprite_simple_image.save_png("res://src/testing/test_atlas/bla.png"))


