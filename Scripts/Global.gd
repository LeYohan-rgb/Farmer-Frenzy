extends Node

var debug_mode : bool = true
#GAME VARIABLES
var player_1_wins : int = 0
var player_2_wins : int = 0
var game_time : int = 0

#GAME PARAMETERS
var farmer_fight_velocity : int = 275
var player_1_health : float = 50.0
var player_2_health :float = 50.0
var recharge_time : float = 3.0
var speed = {
	"kernel" : 1500,
	"mango" : 1000,
	"watermelon" : 750,
	"watermelon_seeds" : 1750.0,
	"papaya" : 1500
}

#BUYING MECHANIC
var plr_currency : int = 0
var bought_fruits : Dictionary = {
	"Mango": true,
	"Avocado": false,
	"Cocoa": false,
	"Coconut": false,
	"Guava": false,
	"Papaya": true,
	"Watermelon": true,
	"Pineapple": false
}
#GAME VARIABLES
var is_in_cooldown = {
	1:
		{1: false, 2: false, 3: false},
	2:
		{1: false, 2: false, 3: false}
}
var player_1_dmg_boost : float = 1
var player_2_dmg_boost : float = 1
var shield : Array = [10, 10] #first player, second player
var kernel_amount : Array = [10, 10]
var is_shielding : Array = [false, false] #1st, #2nd
var bean_amount : Array = [0, 0]
var damage : Dictionary = {
	"kernel" : 1.0,
	"mango" : 2.0,
	"watermelon" : 3.0,
	"watermelon_seed" : 2.0,
	"papaya" : 0.25
}


#GAME_MODES
var is_in_farmer_fight : bool = false

var player_name_1 : String = "Emiliano"
var player_name_2 : String = "Jerónimo"

#FARMER_FIGHT_VARIABLES
var player_1_kernels : int = 10
var player_2_kernels : int = 10

var player_1_fruits : Array = ["","",""]
var player_2_fruits : Array = ["","",""]

#BEGINNING MENU FARMER FIGHT
var fruit_selected : String = ""

var fruit_prices : Dictionary = {
	"Mango": 0,
	"Avocado": 100,
	"Cocoa": 100,
	"Coconut": 100,
	"Guava": 100,
	"Papaya": 0,
	"Watermelon": 0,
	"Pineapple": 100
}

var cooldown : Dictionary = {
	"Mango" : 5,
	"Avocado" : 1,
	"Cocoa" : 1,
	"Coconut" : 1,
	"Guava" : 1,
	"Papaya" : 15,
	"Watermelon" : 5,
	"Pineapple" : 1
}

var fruit_bean_costs : Dictionary = {
	"Mango": 1,
	"Avocado": 2,
	"Cocoa": 3,
	"Coconut": 4,
	"Guava": 5,
	"Papaya": 0,
	"Watermelon": 0,
	"Pineapple": 8
}

var fruit_descriptions : Dictionary = {
	"Mango": "Throws five big mangos succesively; they get stronger when thrown closer to the river.",
	"Avocado": "Avocados are a fruit that grow on trees; they are native to Central America.",
	"Cocoa": "Cocoa is a fruit that is native to Latin America, and are cultivated in Africa.",
	"Coconut": "Coconut is a popular palm fruit of the genus Cocos. It is native to South-East Asia and Oceania.",
	"Guava": "They are native to South, Central America and the Carribean, and now cultivated around the world.",
	"Papaya": "Papayas are a fruit in the genus Carica. They originate from Latin America and are cultivated around the world.",
	"Watermelon": "Watermelons are a melon fruit that is cultivated around the world; they are native to Africa.",
	"Pineapple": "Pineapples are a tropical fruit of the genus Ananas."
}

var long_description : Dictionary = {
	"Mango": "Throws five big mangos succesively; they get stronger when thrown closer to the river.",
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
	
	
	
#IN-GAME FRUIT VARIABLES
var watermelon_is_alive : Array = [false, false]
#O : DORMANT, 1: CAN_START_CHARGE, 2: ISCHARGING, 3: DEPLETING
var papaya_charging_state : Array = [0,0]
var papaya_seeds_count : Array = [40,40]

func num_to_ordinal(num : int) -> String:
	if num == 1:
		return "first"
	if num == 2:
		return "second"
	if num == 3:
		return "third"
	else:
		return ""
		
func fruit_to_slot(fruit : String, plr : int) -> int:
	if plr == 1:
		for i in range(3):
			if Global.player_1_fruits[i] == fruit:
				return i+1
	else:
		for i in range(3):
			if Global.player_2_fruits[i] == fruit:
				return i+1
	return 0

func is_fruit_in_party(fruit : String) -> bool:
	for i in range(3):
		if Global.player_1_fruits[i] == fruit:
			return true
		if Global.player_2_fruits[i] == fruit:
			return true
	return false
