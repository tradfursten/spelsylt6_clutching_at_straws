extends Resource

class_name Item

export(String) var name = ""
export(Texture) var texture

func combine(other):
	print("Combining!")
	match name:
		"Chicken":
			return combine_chicken(other)
		"Anvil":
			return combine_anvil(other)
	return self


func combine_chicken(other):
	match other.name:
		"Anvil":
			return load("res://assets/items/blood.tres")
	return self
			
func combine_anvil(other):
	match other.name:
		"Chicken":
			return load("res://assets/items/blood.tres")
	return self
