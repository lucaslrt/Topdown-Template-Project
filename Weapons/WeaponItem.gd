extends Resource
class_name WeaponItem, "res://Weapons/Punch/Hand.png"

enum ATTACK_TYPE {HAND, SHOOT}

export(String) var name = ""
export(Texture) var icon
export(ATTACK_TYPE) var type
export(String) var state_name
export(PackedScene) var hitbox_collision_area
