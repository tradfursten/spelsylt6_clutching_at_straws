extends Resource

class_name Item

export(String) var name = ""
export(Texture) var texture

func get_key(name, other_name):
	var key: String
	if name < other_name:
		key = name + ":" + other_name
	else:
		key = other_name + ":" + name
	return key
	
func combine(other):
	var key = get_key(name, other.name)
	if ItemCombinations.COMBINATIONS.has(key):
		return ItemCombinations.COMBINATIONS[key]
	else:
		return null

