extends Node2D

onready var Deck = $CardController/Deck1
onready var Player = $CardController/SprinterHand
onready var PlayedCards = $CardController/PlayedCards
onready var Table = $Table

var card = []

enum {
	SELECT_CARD
	MOVE_ROUND
	ENDROUND
	START
}

var gamestate
var currentround
var card_selected = false
var player_card
var player_moved = false


# Called when the node enters the scene tree for the first time.
func _ready():
	gamestate = SELECT_CARD


func _process(delta: float) -> void:
	match gamestate:
		SELECT_CARD:
			player_moved = false
			Player.allow_selection(true)
			if card_selected:
				Player.allow_selection(false)
				PlayedCards.play_war()
				Player.move_unused_card()
				gamestate = MOVE_ROUND
		MOVE_ROUND:
			if !player_moved:
				Table.move_player(player_card.cardvalue)
				player_moved = true
			card_selected = false
			gamestate = SELECT_CARD
			
			



#### SIGNAL FUNCTIONS

func _card_selected(card):
	player_card = card
	Player.allow_selection(false)
	Player.search_remove_card(card)
#	print("selected card:" + str(player_card.cardvalue))
	PlayedCards.player_card = player_card
	get_tree().call_group("players", "make_active", card)
	card_selected = true


func _on_DrawButton_pressed():
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().call_group("players", "draw_cards", 4)
	



	
