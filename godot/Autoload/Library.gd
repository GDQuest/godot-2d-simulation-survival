extends Node

const BLUEPRINTS_PATH := "res://Entities/Blueprints/"
const BLUEPRINT := "Blueprint.tscn"
const ENTITIES_PATH := "res://Entities/Entities/"
const ENTITY := "Entity.tscn"

var entities := {}
var blueprints := {}
var substitutions := {"Boulder": "Stone", "Tree": "Lumber"}


func _ready() -> void:
	_find_entities_in("res://Entities")


func _find_entities_in(path: String) -> void:
	var directory := Directory.new()
	var error := directory.open(path)

	if error != OK:
		Log.log_error(error)
		return

	error = directory.list_dir_begin(true, true)
	if error != OK:
		Log.log_error(error)
		return

	var filename := directory.get_next()
	while not filename.empty():
		if directory.current_is_dir():
			_find_entities_in("%s/%s" % [directory.get_current_dir(), filename])
		else:
			if filename.rfind(BLUEPRINT) != -1:
				blueprints[filename.substr(0, filename.rfind(BLUEPRINT))] = load(
					"%s/%s" % [directory.get_current_dir(), filename]
				)
			if filename.rfind(ENTITY) != -1:
				entities[filename.substr(0, filename.rfind(ENTITY))] = load(
					"%s/%s" % [directory.get_current_dir(), filename]
				)
		filename = directory.get_next()


func get_filename_from(node: Node) -> String:
	var filename := node.filename.substr(node.filename.rfind("/") + 1).replace(BLUEPRINT, "").replace(
		ENTITY, ""
	)
	if substitutions.has(filename):
		filename = substitutions[filename]

	return filename
