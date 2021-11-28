tool
extends Sprite

func zoom_changed():
	material.set_shader_param("yzoom", get_viewport().global_canvas_transform.y.y)

func _on_Lava_item_rect_changed():
	material.set_shader_param("scale", scale)
	
func _process(delta):
	zoom_changed()


