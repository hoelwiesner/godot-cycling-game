extends Node2D

var player_card

onready var PlayerCardPosition = $SprinterDeckPosition

func play_war():
	player_card.move_card(PlayerCardPosition.position, 0.0, Vector2(1.0,1.0))
