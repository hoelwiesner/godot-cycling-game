extends Node2D

onready var Deck = get_node("../Deck_1")

var hand = []
var cardpath = "res://Assets/Cards/"
var card_width
export var cardscale = Vector2(1, 1)
var cards_in_hand = []
var unused_values = []

func draw_cards(num):
	hand += Deck.give_cards(num)
	display_value()
	place_cards()
#	print(Deck.unused)
		
func display_value():
	for i in hand.size():
		hand[i].change_value(str(hand[i].cardvalue))
		hand[i].connect("active_card", self, "_active_card")


func place_cards():
	var path_length = $Path2D.curve.get_baked_length()
	var space
	var ideal_cardwidth
	var hand_width

	for i in hand.size():
		card_width = hand[0].card_width()
		ideal_cardwidth = card_width * 1.5
		hand_width = ideal_cardwidth * hand.size()
		add_child(hand[i])

		space = path_length
		$Path2D/PathFollow2D.offset = 0.0
		if hand_width < path_length:
			$Path2D/PathFollow2D.offset = (space - hand_width)/2

#			print("ideal cardwidth space: " + str(ideal_cardwidth))
		else:
			ideal_cardwidth = space / hand.size()
#			print("ideal cardwidth crowded: " + str(ideal_cardwidth))
		
		for card in hand.size():
			if !hand[card].dealt:
				hand[card].position = $DeckLocation.position
			hand[card].handposition = $Path2D/PathFollow2D/DeckSpawner.get_global_position()
			hand[card].handrotation = $Path2D/PathFollow2D/DeckSpawner.get_global_transform().get_rotation()
			hand[card].move_card(hand[card].handposition, hand[card].handrotation)
			hand[card].dealt = true

			$Path2D/PathFollow2D.offset += ideal_cardwidth
		$Path2D/PathFollow2D.offset = 0.0 # a bit redundant but could prevent bugs
	# Debug - can delete
	for i in hand.size():
		cards_in_hand.append(hand[i].cardvalue)
	cards_in_hand = []
	# End

func reset_hand():
	for i in hand.size():
		hand[i].kill_card()
	hand = []

func allow_selection(_selectable: bool):
	for i in hand.size():
		hand[i].selectable = _selectable

func search_remove_card(_card):
	var i = hand.find(_card)
	hand.remove(i)

func move_unused_card():
	for i in hand.size():
		hand[i].dealt = false
		Deck.unused.append(hand[i].cardvalue)
	print("Unused:")
	print(Deck.unused)
	reset_hand()

func _active_card(card):
	for i in hand.size():
		hand[i].make_active(card)
