extends Control

const JournalListItemScene = preload("res://scenes/menus/journal_list_item.tscn")

@onready var quests_node: VBoxContainer = $MarginContainer/VBoxContainer/MarginContainer/Quests

func _ready() -> void:
	load_menu()

# Load the quests onto the journal menu from the QuestService
func load_menu() -> void:
	var quests: Dictionary = QuestService.get_all_quests()

	for quest in quests["Active"]:
		assert(quest is QuestExtended, "Quest not of the correct type!")
		var quest_list_item = JournalListItemScene.instantiate()
		quest_list_item.quest = quest
		quests_node.add_child(quest_list_item)

	for quest in quests["Completed"]:
		assert(quest is QuestExtended, "Quest not of the correct type!")
		var quest_list_item = JournalListItemScene.instantiate(quest)
		quests_node.add_child(quest_list_item)

	print("Quests: [%s]" % quests)

	# Create a button for each quest
	var button: Button = Button.new()
	button.text = "Test"


func _clear_quest_list() -> void:
	var quests =quests_node.get_children()
	for quest in quests:
		quest.queue_free()

func render_quests() -> void:
	var quests: Dictionary = QuestService.get_all_quests()

	for quest in quests["Active"]:
		var quest_list_item = JournalListItem.new()
		quest_list_item.quest = quest
		quests_node.add_child(quest_list_item)
