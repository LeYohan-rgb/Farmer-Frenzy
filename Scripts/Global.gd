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
var plr_currency : int = 1000
var bought_fruits : Dictionary = {
	"Mango": true,
	"Avocado": false,
	"Cocoa": false,
	"Coconut": false,
	"Guava": false,
	"Papaya": true,
	"Watermelon": true,
	"Pineapple": true
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
var can_shield : Array = [true, true] 

var bean_amount : Array = [0, 0]
var damage : Dictionary = {
	"kernel" : 1.0,
	"mango" : 2.0,
	"watermelon" : 3.0,
	"watermelon_seed" : 2.0,
	"papaya" : 0.25,
	"pineapple" : [2, 3, 4]
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
	"Avocado" : 0,
	"Cocoa" : 0,
	"Coconut" : 0,
	"Guava" : 0,
	"Papaya" : 15,
	"Watermelon" : 5,
	"Pineapple" : 5
}

var fruit_bean_costs : Dictionary = {
	"Mango": 5,
	"Avocado": 0,
	"Cocoa": 0,
	"Coconut": 0,
	"Guava": 0,
	"Papaya": 5,
	"Watermelon": 5,
	"Pineapple": 0
}

var fruit_descriptions : Dictionary = {
	"Mango": "Throws five big mangos succesively; they get stronger when thrown closer to the river.",
	"Avocado": "N/A",
	"Cocoa": "N/A",
	"Coconut": "N/A",
	"Guava": "N/A",
	"Papaya": "Charge papaya seeds to launch them at a high rate; the closer to the river, the larger they become.",
	"Watermelon": "Launch small fast seeds that ricochet off the map's boundaries; their spread is larger closer to the river.",
	"Pineapple": "N/A"
}

var long_description : Dictionary = {
	"Mango": 
		"Mango is an offensive fruit. When harvested, it automatically launches five grown mangos succesively in a straight line at the opponent.

The closer the farmer is to the river, the more powerful the thrown mangos become. They can be as weak as a kernel or up to three times as powerful.

Mangos are slightly slower than kernels, but they are bigger. This allows them to cover a wider area while inflicting a lot of damage.",

	"Avocado": "N/A",
	"Cocoa": "N/A",
	"Coconut": "N/A",
	"Guava": "N/A",
	
	"Papaya": "Papaya is an offensive fruit. When harvested, the farmer can collect up to 40 papaya seeds, which they can keep for the rest of the fight; this allows the farmer to charge seeds. The farmer can charge for up to 3 seconds before launching papaya seeds. 

The longer they charge, the more seeds they launch; they are released at an extremely high rate. The closer the farmer is to the river, the larger the seeds become. They grow up to twice the size of a farmer's head!",

	"Watermelon": "Watermelon is an offensive fruit. When harvested, the farmer launches a watermelon slice containing 7 small seeds. At any moment, the farmer can detonate the slice, causing the seeds to quickly fan out from its path.

The farther the farmer is to the river, the wider the spread becomes; at maximum range, the seeds can cover the opponent's entire side of the map. These fast seeds can ricochet off the map's boundaries up to 3 times, losing speed with each bounce.",

	"Pineapple": "N/A"
}

func wait(sec : float):
	await get_tree().create_timer(sec).timeout
	
	
	
#IN-GAME FRUIT VARIABLES
var watermelon_is_alive : Array = [false, false]
#O : DORMANT, 1: CAN_START_CHARGE, 2: ISCHARGING, 3: DEPLETING
var papaya_charging_state : Array = [0,0]
var papaya_seeds_count : Array = [40,40]
var pineapple_is_on : Array = [false, false]
var pineapple_effect : Array = [false, false]

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
