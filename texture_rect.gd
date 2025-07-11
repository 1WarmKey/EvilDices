extends TextureRect


#Перетаскивание из изначальной точки
func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(100,100)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	texture = null
	
	return preview_texture.texture


#Управляет во время перетаскивания
func _can_drop_data(at_position, data):
	return data is Texture2D

#Положить
func _drop_data(at_position, data):
	texture = data
