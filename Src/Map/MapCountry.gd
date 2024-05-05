extends Node2D

var id = -1



#{"id": 2, "name": "Great Britain", "pos_x": 535, "pos_y": 101, "image": "country_2.png"},
func setup(scenario_path, country_data):
	var image = load("res://Scenarios/"+scenario_path+"/"+country_data.image)
	if null == image: return false
	
	$Sprite.texture = image
	id = country_data.id
	var size = image.get_size()
	$z/Label.text = country_data.name
	$z.position = size/2

	# Connect signals
	Events.map_select_country.connect(select)
	Events.map_highlight_countries.connect(highlight_multiples)
	Events.map_highlight_countries_clear.connect(highlight_clear)
	
	# Make shader unique
	$Sprite.set_material($Sprite.get_material().duplicate())
	return true

func select(country_id, color, show_name):
	if country_id == id:
		if show_name:
			$z/Label.show()
		$Sprite.material.set_shader_parameter("selected_color", color)
		$Sprite.material.set_shader_parameter("selected", true)
	else:
		$z/Label.hide()
		$Sprite.material.set_shader_parameter("selected", false)

		

func highlight_multiples(country_id, color):
	if country_id == id:
		$Sprite.material.set_shader_parameter("overlay_color", color)
		$Sprite.material.set_shader_parameter("overlay", true)


func highlight_clear(country_id):
	if country_id == id:
		$Sprite.material.set_shader_parameter("overlay", false)

