@tool
extends AnimatedTexture
class_name AnimatedTextureSheet

# A tool that creates an animatedTexture out of tightly packed spriteSheets.
# Take a Sprite create a single AtlasTexture with the wanted frames cropepd out
# and give it as input to this resource. Set the number of vFrames and hFrames
# accordingly and it automatically detects the frames and makes an
# animatedTexture out of them.

# AnimatedTextureSheet can be used everywhere where AnimatedTextures are used:
# Directly as Sprite2D or even as Tile in a TileSet

# Godot4.0 broke this tool a little...
# A workaround is to set the vFrames and hFrames before loading the atlas into
# the tool. Otherwise the cropping fails and the frames are all over the place.

@export var atlasTexture : AtlasTexture :
	set(value):
		atlasTexture = value
		_on_change()
@export var vFrame : int = 1:
	set(value):
		vFrame = value
		_on_change()
@export var hFrame : int = 1:
	set(value):
		hFrame = value
		_on_change()

var frame_array : Array = []
var num_frames : int

func get_plugin_icon():
	pass
	# return Tree.get_editor_interface().get_base_control().get_icon("Node", "EditorIcons")

func _on_change():
	assert(hFrame >= 1 and vFrame >= 1)
	num_frames = hFrame * vFrame
	set_frames(num_frames)
	if(atlasTexture == null):
		print("no atlas texture")
		return
	var atlas_region : Rect2 = atlasTexture.get_region()
	var frame_width : int = int(atlas_region.size.x / vFrame)
	var frame_height : int = int(atlas_region.size.y / hFrame)
	
	print("frame_width " + str(frame_width) )
	print("frame_height " + str(frame_height))
	var atlas_image : Image = atlasTexture.get_image()
	
	for h in range(hFrame):
		for v in range(vFrame):
			var rect := Rect2(Vector2(v * frame_width, h * frame_height), Vector2(frame_width, frame_height))
			var my_current_frame = v+h
			print("frame: " + str(my_current_frame) + " rect: " + str(rect))
			var image := Image.new()
			image.create(frame_width, frame_height, false, Image.FORMAT_RGBA8)
			image.resource_name = str("frameImage", my_current_frame)
			image.blit_rect(atlas_image, rect, Vector2(0, 0))
			# print(image.save_png("res://test/" + str(current_frame) + ".png"))
			var frame_texture : ImageTexture = ImageTexture.create_from_image(image)
			# set_frame_texture(current_frame, frame_texture)
			frame_array.push_back(frame_texture)
	
	for frame in range(num_frames):
		set_frame_texture(frame, frame_array[frame])
	
	emit_signal("property_list_changed")
	print()
