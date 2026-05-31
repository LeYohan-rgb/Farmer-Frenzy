extends Node


var player_name_1 = "Emiliano"
var player_name_2 = "Jerónimo"

var player_1_fruits = ["","",""]
var player_2_fruits = ["","",""]

#BEGINNING MENU FARMER FIGHT
var fruit_selected = ""

var fruit_prices = {
	"Mango": 0,
	"Avocado": 0,
	"Cocoa": 0,
	"Coconut": 0,
	"Guava": 0,
	"Papaya": 0,
	"Watermelon": 0,
	"Pineapple": 0
}

var fruit_bean_costs = {
	"Mango": 1,
	"Avocado": 2,
	"Cocoa": 3,
	"Coconut": 4,
	"Guava": 5,
	"Papaya": 6,
	"Watermelon": 7,
	"Pineapple": 8
}

var fruit_descriptions = {
	"Mango": "Mango is a fruit that is native to South Asia, and they are cultivated worldwide.",
	"Avocado": "Avocados are a fruit that grow on trees; they are native to Central America.",
	"Cocoa": "Cocoa is a fruit that is native to Latin America, and are cultivated in Africa.",
	"Coconut": "Coconut is a popular palm fruit of the genus Cocos. It is native to South-East Asia and Oceania.",
	"Guava": "They are native to South, Central America and the Carribean, and now cultivated around the world.",
	"Papaya": "Papayas are a fruit in the genus Carica. They originate from Latin America and are cultivated around the world.",
	"Watermelon": "Watermelons are a melon fruit that is cultivated around the world; they are native to Africa.",
	"Pineapple": "Pineapples are a tropical fruit of the genus Ananas."
}

func wait(sec : float):
	await get_tree().create_timer(sec).timeout
