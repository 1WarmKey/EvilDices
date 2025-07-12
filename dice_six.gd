extends Node2D

@onready var dice_sprite = $Dice_sprite
@onready var anim_player = $AnimationPlayer
@onready var dice_sound = $DiceSound

var annimated_massive = [
	"Roll to 1",
	"Roll to 2",
	"Roll to 3",
	"Roll to 4",
	"Roll to 5",
	"Roll to 6"
]

func animation_dice_6(d):
	anim_player.play(annimated_massive[d - 1])

func _on_button_pressed() -> void:
	animation_dice_6(dices())
	dice_sound.play()
	
func dices():
	var x = randi() % 6 + 1
	print(x)
	return x
