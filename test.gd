extends CanvasLayer

@onready var VerticalContainer : VBoxContainer = get_node("Anchor/Box/Vertical Container")
@onready var ResetButton : Button = get_node("Anchor/Box/Reset Button")
@onready var ResetBar : TextureProgressBar = get_node("Anchor/Box/Reset Button/ProgressBar")

const CENTER_BOX : int = 12
const RESET_VALUE : float = 3.0

var reset_progress : float = 0.0

func _ready():
	
	SavesManager.Main = self
	
	var save_file : SaveFile = SavesManager.load_data()
	
	reset_boxes(save_file)

func _process(delta):
	
	if ResetButton.button_pressed:
		reset_progress += delta
		
		if reset_progress >= RESET_VALUE:
			reset_boxes()
			
			reset_progress = 0.0
		
	else:
		reset_progress = 0.0
	
	ResetBar.value = (reset_progress / RESET_VALUE) * 100

func reset_boxes(save_file : SaveFile = null) -> void:
	var boxes : Array[BingoSquareRender] = compile_boxes()
	
	for i in range(len(boxes)):
		boxes[i].reset()
	
	if save_file == null:
		var bingo_squares : Array[String] = Compiler.compile_squares("res://data/bingo_squares.txt")
		var free_squares : Array[String] = Compiler.compile_squares("res://data/free_spaces.txt")
		
		bingo_squares.shuffle()
		free_squares.shuffle()
		
		boxes[CENTER_BOX].text = free_squares[0]
		
		for i in range(len(boxes)):
			if i != CENTER_BOX:
				boxes[i].text = bingo_squares[i]
	
	else:
		for i in range(len(boxes)):
			boxes[i].text = save_file.save_strings[i]
			if save_file.save_values[i]: boxes[i].force_press()
	
	SavesManager.save_data()

func compile_boxes() -> Array[BingoSquareRender]:
	
	var return_array : Array[BingoSquareRender] = []
	
	for hbox in VerticalContainer.get_children():
		for bbox in hbox.get_children():
			if bbox is BingoSquareRender:
				return_array.append(bbox)
	
	return return_array

func compile_strings() -> Array[String]:
	
	var return_array : Array[String] = []
	
	for i in compile_boxes():
		return_array.append(i.text)
	
	return return_array

func compile_values() -> Array[bool]:
	
	var return_array : Array[bool] = []
	
	for i in compile_boxes():
		return_array.append(i.is_button_pressed)
	
	return return_array
