extends Resource
class_name Achievement

## The name of the achievement, doesn't need to be unique
@export var name: String
## The ID of the achievement, needs to be unique
@export var id: StringName
## The description of the achievement, used to communicate what the achievement does.
@export var description: String
## Image for the achievement
@export var cover_texture: Texture2D
## Determines if the achievement is secret or not
@export var is_secret: bool
## Says if the player has achieved this achievement or not
@export var achieved: bool
