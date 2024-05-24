extends Node

const DATA_SAVE_PATH : String = "user://save_data.tres"

@export var Main : CanvasLayer = null

func save_data() -> void:
	var new_file : SaveFile = SaveFile.new()
	
	new_file.save_strings = Main.compile_strings()
	new_file.save_values = Main.compile_values()
	
	ResourceSaver.save(new_file, DATA_SAVE_PATH)

func load_data() -> SaveFile:
	
	var file : SaveFile
	
	if not FileAccess.file_exists(DATA_SAVE_PATH):
		print("Failed loading data")
		file = null
	else:
		print("Loading data...")
		file = ResourceLoader.load(DATA_SAVE_PATH)
	
	return file
