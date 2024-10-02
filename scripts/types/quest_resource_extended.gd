extends Quest
class_name QuestExtended

var completed_objectives: Dictionary = {}
var active_objectives: Dictionary = {}
var quest_identifier: String = ""

# To create a quest with a single objective
func _init(
	name: String,
	description: String,
	identifier: String, # This is how events will identify this quest
	objective_id: String, # Starting objective
	objective_description: String
):
	self.quest_name = name
	self.quest_description = description
	self.quest_identifier = identifier
	active_objectives[objective_id] = objective_description


# When an objectve in a list is completed, emit this signal
signal sub_objective_completed(quest_id: String,objective_id: String, description: String)

func add_objective(objective_id: String, description: String):
	active_objectives[objective_id] = description
	updated.emit()

func get_objective_description(objective_id: String):
	var response = active_objectives[objective_id]
	if response != null:
		return response

	return completed_objectives[objective_id]

func advance_objective(
	current_objective_id: String,
	new_objective_id: String,
	description: String
):
	assert(current_objective_id != null, "Objective cannot be null")
	assert(new_objective_id != "", "Active objective ID cannrot be empty")
	assert(description != "", "Description cannot be empty")

	# Check to see if the objective is in the active objectives
	if current_objective_id not in active_objectives:
		print("Cannot advance to objective: [%s] because objective [%s] is not in active objectives" % [new_objective_id, current_objective_id])
		return


	# Complete the current objective
	var old_description = active_objectives[current_objective_id]
	completed_objectives[current_objective_id] = old_description
	active_objectives.erase(current_objective_id)

	# Add the next objective
	active_objectives[new_objective_id] = description
	sub_objective_completed.emit(current_objective_id, old_description)
	update()

func serialize() -> Dictionary:
	var serialized_quest: Dictionary = {
		"quest_name": self.quest_name,
		"quest_description": self.quest_description,
		"quest_id": self.quest_identifier,
		"active_objectives": self.active_objectives,
		"completed_objectives": self.completed_objectives
	}

	return serialized_quest

func de_serialize(quest_data: Dictionary):
	self.quest_name = quest_data["quest_name"]
	self.quest_description = quest_data["quest_description"]
	self.quest_identifier = quest_data["quest_id"]
	self.active_objectives = quest_data["active_objectives"]
	self.completed_objectives = quest_data["completed_objectives"]