extends Node

func _init():
	start_quest(
		"Life goal",
		"Hijack a plane and fly it into the new world trade center",
		"test_quest",
		"hijack_plane",
		"Go to the airport and hijack a plane"
	)
	
# Primarily used by the journal menu to load all quests
# The quests will be organized by pool, with the
# pool name as the key
# Value is an array of QuestExtended
func get_all_quests() -> Dictionary:
	var pools: Array[BaseQuestPool] = QuestSystem.get_all_pools()
	var quests: Dictionary = {}
	for pool in pools:
		quests[pool.name] = pool.get_all_quests() as Array[QuestExtended]
	return quests

# Check if a quest exists yet
func was_quest_declared(quest_identifier: String):

	# OOf, nested for loops!
	var pools: Array[BaseQuestPool] = QuestSystem.get_all_pools()
	for pool in pools:
		for quest in pool.get_all_quests():
			if quest.quest_name == quest_identifier:
				return true
	return false

func start_quest(
	quest_name: String,
	quest_description: String,
	quest_identifier: String,
	objective_id: String,
	objective_description: String
):
	if was_quest_declared(quest_name):
		print("Quest already exists: [%s]" % quest_name)
		return

	var quest: QuestExtended = QuestExtended.new(
		quest_name,
		quest_description,
		quest_identifier,
		objective_id,
		objective_description
	)
	
	QuestSystem.start_quest(quest)

# Check to see if the user has started a specific quest objective
func has_quest_objective(quest_identifier: String, objective_identifier: String):
	var active_quests: Array[Quest] = QuestSystem.get_active_quests()

	for quest in active_quests:
		if quest.quest_name == quest_identifier:
			assert(quest is QuestExtended, "Invalid quest typ!")

			# If this variable ins'
			var objective_description = quest.completed_objectives[objective_identifier]

			if objective_description != null:
				return true
			
			objective_description = quest.active_objectives[objective_identifier]

			if objective_description != null:
				return true

	# Didn't find objetive? Sad.
	return false

# func update_quest(quest_identifier: String, get_objective_description: String, objective_identifier: String):


func complete_quest(quest_id: String):
	print("Quest completed: [%s]" % quest_id)
	pass

# Load quests from a dictionary
func de_serialize_quests(quests: Dictionary):
	for quest in quests:
		var quest_data: Dictionary = quests[quest]
		var quest_name: String = quest_data["name"]
		var quest_description: String = quest_data["description"]
		var quest_identifier: String = quest_data["id"]
		var objectives: Array[Dictionary] = quest_data["objectives"]
		
		var new_quest: QuestExtended = QuestExtended.new(
			quest_data["name"],
			quest_data["description"],
			quest_data["id"],
			quest_data["objectives"][0]["id"],
			quest_data["objectives"][0]["description"]
		)
		

	pass

func get_quests() -> Dictionary:
	return QuestSystem.quests_as_dict()

func _on_quest_updated(quest_id: String, quest_data: Dictionary):
	print("Quest updated: [%s]" % quest_id)
	print("Here's the quest data: [%s] as a little treat" % quest_data)
