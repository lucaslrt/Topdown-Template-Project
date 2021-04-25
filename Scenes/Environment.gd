extends Node2D

#var noise
#var map_size = Vector2(80, 60)
var noise := OpenSimplexNoise.new()
var total_size
var grass_cap = 0.5
var road_caps = Vector2(0.3, 0.05)
var water_caps = 0.64
var environment_caps = Vector3(0.6, 0.1, 0.04)
var num_nature_tiles = 10
var tree_instance_path = "res://Environment/Tree/Tree.tscn"
var ambient_type = "Spring"

export(Vector2) var map_size = Vector2(16, 16)
export(int) var tile_size = 32
export (int, 0 , 20) var octaves = 8
export (int, 0 , 200) var period = 100
export (float, 0 , 2.0) var lacunarity = 1.6
export (float, 0 , 20) var persistence = 20

onready var grass_obj = $Grass
onready var ground_obj = $Ground
onready var lake_obj = $Lake
onready var nature_obj = $GroundObjs
onready var tree_sort = get_tree().current_scene.get_node("YSort/Trees")

func _ready():
	total_size = map_size * 2
#	print("total_size = ", total_size)
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 1.0
	noise.period = 12
	noise.persistence = 0.7
#	generate_map()
	pass
	
func generate_map():
	
	make_grass_map()
	make_road_map()
	make_water_map()
#	make_fence()
	make_nature_map()
#	make_environment_map()
#	make_background()
	pass

func make_grass_map():
	for x in range(-total_size.x / 2, total_size.x):
		for y in range(-total_size.y / 2, total_size.y):
#			var a = noise.get_noise_2d(x,y)
#			if a < grass_cap:
			grass_obj.set_cell(x,y,0)
	
	grass_obj.update_bitmask_region(Vector2(-total_size.x / 2, -total_size.y / 2), Vector2(total_size.x, total_size.y))
	pass
	
func make_road_map():
	for x in range(1, map_size.x - 1):
		for y in range(1, map_size.y - 1):
			var a = noise.get_noise_2d(x,y)
#			print("noise ground = ", a)
			if a < road_caps.x and a > road_caps.y:
				grass_obj.set_cell(x,y,-1)
				ground_obj.set_cell(x,y,0)
	
	ground_obj.update_bitmask_region(Vector2(0,0), Vector2(map_size.x, map_size.y))
	pass
	
func make_water_map():
	for x in range(1, map_size.x - 1):
		for y in range(1, map_size.y - 1):
			var a = noise.get_noise_2d(x,y)
#			print("noise water = ", a)
			if a > water_caps:
				grass_obj.set_cell(x,y,-1)
				lake_obj.set_cell(x,y,0)
	
	lake_obj.update_bitmask_region(Vector2(0,0), Vector2(map_size.x, map_size.y))
	pass
	
func make_fence():
	for y in map_size.y * 2:
#		if($YSort/Fence.get_cell())
		$YSort/Fence.set_cell(0,y,1)
		$YSort/Fence.set_cell(map_size.x * 8, y, 1)
				
	for x in range(0, map_size.x * 8 - 1, 2):
		$YSort/Fence.set_cell(x,0,0)
		$YSort/Fence.set_cell(x,map_size.y * 2 - 1,0)
	pass

func make_nature_map():
	for x in range(-total_size.x / 2, total_size.x):
		if x != 0 and x != map_size.x - 1:
			for y in range(-total_size.y / 2, total_size.y):
				if y != 0 and y != map_size.y - 1:
#					var a = noise.get_noise_2d(x,y)
#					print("noise = ", a)
##					if a < environment_caps.x and a > environment_caps.y or a < environment_caps.z:
#					if a < 0:
					var chance = randi() % 100
					if chance < 10 and grass_obj.get_cell(x,y) != -1:
						var num = randi() % num_nature_tiles + 1
	#					print("Tile selecionado = ", num)
						nature_obj.set_cellv(Vector2(x,y), num)

	for x in range(-total_size.x / 2, total_size.x):
		if x != 0 and x != map_size.x - 1:
			for y in range(-total_size.y / 2, total_size.y):
				if y != 0 and y != map_size.y - 1:
					var chance = randi() % 100
					if chance < 10 and grass_obj.get_cell(x,y) != -1:
						var new_tree = load(tree_instance_path).instance()
						new_tree.set_position(Vector2(x* tile_size, y* tile_size) )
						tree_sort.add_child(new_tree)
#						var type = randi() % 3 + 1
#						new_tree.get_node("AnimatedSprite").play("type_" + str(type))
#						$YSort/Trees.add_child(new_tree)
#						grass_obj.set_cell(x,y,-1)
#						$YSort/Trees.set_cellv(Vector2(x,y), 1)
	pass
	
func make_background():
	for x in map_size.x:
		for y in map_size.y:
			if grass_obj.get_cell(x,y) == -1:
				if grass_obj.get_cell(x,y-1) == 0:
					$YSort/Background.set_cell(x,y,0)
					
	$YSort/Background.update_bitmask_region(Vector2(0,0), Vector2(map_size.x, map_size.y))
	pass
