extends Node

func save_profile():
	var p: Dictionary = {
		"max_hp": PlayerState.max_hp,
		"attack": PlayerState.attack,
		"focus": PlayerState.focus,
		"abilities": PlayerState.abilities,
		"forgotten": PlayerState.forgotten,
		"perks": PlayerState.perks,
		"lost_allies": PlayerState.lost_allies
	}
	var cf := ConfigFile.new()
	cf.set_value("data", "profile", JSON.stringify(p))
	cf.save("user://save.cfg")

func load_profile() -> bool:
	var cf := ConfigFile.new()
	if cf.load("user://save.cfg") != OK:
		return false
	var raw: String = String(cf.get_value("data", "profile", ""))
	if raw == "":
		return false

	var parsed: Variant = JSON.parse_string(raw)
	if typeof(parsed) != TYPE_DICTIONARY:
		return false
	var p: Dictionary = parsed as Dictionary

	PlayerState.max_hp = int(p.get("max_hp", 100))
	PlayerState.attack = int(p.get("attack", 10))
	PlayerState.focus = int(p.get("focus", 0))
	PlayerState.abilities = p.get("abilities", {}) as Dictionary
	PlayerState.forgotten = p.get("forgotten", {}) as Dictionary
	PlayerState.perks = p.get("perks", {}) as Dictionary
	PlayerState.lost_allies = p.get("lost_allies", {}) as Dictionary
	PlayerState.state_changed.emit()
	return true
