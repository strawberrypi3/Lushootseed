extends PanelContainer

const FILE_PATH = "res://vocab.json"

var data : Array
var categories : Array = ["All terms"]
var enabled = true

func _ready():
	data = Global.get_file_data(FILE_PATH)
	
	for term in data:
		var category : String = term["Category"]
		if not categories.has(category):
			categories.append(category)
	
	var v_box_container = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer
	var rich_button = preload("res://scenes/rich_button.tscn")
	for category in categories:
		var category_button = rich_button.instance()
		category_button.text = category
		v_box_container.add_child(category_button)
		category_button.connect("pressed", self, "button_pressed")
	
	for child in v_box_container.get_children():
		child.size_flags_horizontal = SIZE_EXPAND_FILL # 3
		child.size_flags_vertical = SIZE_EXPAND_FILL # 3, maybe change to just fill to make scrolling if there's lots of categories
		

func button_pressed():
	yield(get_tree().create_timer(0.01), "timeout") # to ensure enabled has been updated
	if enabled:
		var v_box_container = $MarginContainer/VBoxContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer
		for child in v_box_container.get_children():
			if child is RichButton:
				if child.pressed:
					if child.get_index() == 0: # "all terms" button
						Global.term_list = data
						get_tree().change_scene("res://scenes/vocab_practice.tscn")
						return
					var category_selected = categories[child.get_index()]
					var results : Array = []
					for card in data:
						if card["Category"].nocasecmp_to(category_selected) == 0:
							results.append(card)
					Global.term_list = results
					get_tree().change_scene("res://scenes/vocab_practice.tscn")
	else:
		enabled = true


func _on_Back_pressed():
	get_tree().change_scene("res://scenes/vocabulary.tscn")


func _on_ScrollContainer_disable_press():
	enabled = false
