extends Node


var card_values = [7, 7, 7, 7, 7, 7, 7, 7]

var deck = []
var unused = []
var values_in_deck = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	makedeck(card_values)
#	# Debug - can delete
#	for i in deck.size():
#		values_in_deck.append(deck[i].cardvalue)
#	print(values_in_deck)
#	values_in_deck = []
#	# End

func give_cards(num):
	var cardreturn = []
	if num > deck.size():
		if unused.size() > 0:
			reshuffle_unused()
		else:
			print("returning 2")
			reshuffle_empty()
		if num > deck.size():
			num = deck.size()
	for i in num:
		cardreturn.append(deck[i])
	for i in cardreturn.size():
		deck.remove(0)
	return cardreturn


func reshuffle_unused():
	var cardscene = load("res://Scenes/Card/Card.tscn")
	var card
	unused.shuffle()
	for i in unused.size():
		card = cardscene.instance()
		card.cardvalue = unused[i]
		card.connect("card_selected",  get_tree().get_root().get_node("Main"), "_card_selected")
		deck.append(card) # append the full instance to the array
	unused = []

func reshuffle_empty():
	var cardscene = load("res://Scenes/Card/Card.tscn")
	var card
	card = cardscene.instance()
	card.cardvalue = 2
	card.connect("card_selected",  get_tree().get_root().get_node("Main"), "_card_selected")
	deck.append(card) # append the full instance to the array

	
func makedeck(_array):
	var cardscene = load("res://Scenes/Card/Card.tscn")
	var card
	for i in _array.size():
		card = cardscene.instance()
		card.cardvalue = _array[i]
		card.connect("card_selected",  get_tree().get_root().get_node("Main"), "_card_selected")
		deck.append(card) # append the full instance to the array
	deck.shuffle()
	

