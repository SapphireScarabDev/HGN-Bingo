extends Node

func compile_squares(path : String) -> Array[String]:
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	
	var square_array : Array[String] = []
	
	var text : String = file.get_as_text()
	
	for t in text.split("\n"):
		if len(t) > 0:
			square_array.append(t)
	
	file.close()
	
	return square_array
