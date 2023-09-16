extends Node

func load_shape_json(file_name: String) -> Dictionary:
	var path = "res://shapes/" + file_name + ".json"
	print("path: " + path)
	var file = FileAccess.open(path, FileAccess.READ)
	var text_content = file.get_as_text()
	var dict = JSON.parse_string(text_content)
	return dict
