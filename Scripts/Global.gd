extends Node

#GAME VARIABLES
var player_1_wins : int = 0
var player_2_wins : int = 0
var game_time : int = 0

#GAME PARAMETERS
var farmer_fight_velocity = 275
var kernel_speed = 1500
var player_1_health = 50
var player_2_health = 50
var recharge_time : float = 3.0

#GAME VARIABLES
var is_in_cooldown = {
	1:
		{1: false, 2: false, 3: false},
	2:
		{1: false, 2: false, 3: false}
}
var player_1_dmg_boost : float = 1
var player_2_dmg_boost : float = 1
var shield = [10, 10] #first player, second player
var kernel_amount = [10, 10]
var is_shielding = [false, false] #1st, #2nd
var bean_amount = [0, 0]
var damage = {
	"kernel" : 1,
	"mango" : 2
}


#GAME_MODES
var is_in_farmer_fight = false

var player_name_1 = "Emiliano"
var player_name_2 = "Jerónimo"

#FARMER_FIGHT_VARIABLES
var player_1_kernels : int = 10
var player_2_kernels : int = 10

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

var cooldown = {
	"Mango" : 3.0,
	"Avocado" : 1.0,
	"Cocoa" : 1.0,
	"Coconut" : 1.0,
	"Guava" : 1.0,
	"Papaya" : 1.0,
	"Watermelon" : 1.0,
	"Pineapple" : 1.0
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
