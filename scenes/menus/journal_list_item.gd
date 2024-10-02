extends Node
class_name JournalListItem

# Represents a queset in the journal menu

@onready var title_label: Label = $VBoxContainer/QuestTitle
@onready var description_label: Label = $VBoxContainer/MarginContainer/QuestDescription
@onready var objective_list: VBoxContainer = $VBoxContainer/ObjectiveList

var quest: QuestExtended:
	set(new_quest):
		quest = new_quest

		# We don't connect signals if we are not in the tree
		if is_inside_tree():
			_connect_quest_signals()
	get:
		return quest

# Called when the node enters the scene tree
func _ready() -> void:
	assert(title_label != null, "Title Label null!")
	assert(objective_list != null, "Objective List null!")

	if (quest != null):
		_connect_quest_signals()

# Connects the quest signals to the journal menu
func _connect_quest_signals() -> void:
	quest.updated.connect(_on_quest_updated)
	quest.update()

func _on_quest_updated() -> void:
	print("Journal menu sees a quest got updated")
	assert(quest is QuestExtended, "Wrong type of quest for this menu!")
	
		
	if (title_label != null):
		title_label.text = quest.quest_name
	else:
		print("Title label is null on quest menu item [%s]" % quest.quest_name)
		
	if (description_label != null):
		description_label.text = quest.quest_description
	else:
		print("Description label is null on quest menu item [%s]" % quest.quest_name)
	# When the quest is updated, re-render the objectives
	
	var objectives: Array[Node] = objective_list.get_children()
	for object in objectives:
		object.queue_free()

	for objective in quest.active_objectives:
		var objective_label = Label.new()
		objective_label.text = "- " + quest.get_objective_description(objective)
		objective_label.name = objective

		var margin_container = MarginContainer.new()
		margin_container.add_child(objective_label)
		objective_list.add_child(margin_container)
