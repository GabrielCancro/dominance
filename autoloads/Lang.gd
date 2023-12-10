extends Node

var language = "es"
var Texts = {
	"market":{"es":"Mercado","en":"Market"},
	"cost":{"es":"Costo","en":"Cost"},
	"select_unit_team_-1":{"es":"Elige una unidad","en":"Choose a unit"},
	"select_unit_team_1":{"es":"Elige un aliado","en":"Choose a ally"},
	"select_unit_team_2":{"es":"Elige un enemigo","en":"Choose a enemy"},
	"end_turn_button":{"es":"Terminar","en":"End"},
	"discards_slot":{"es":"Descarte","en":"Discards"},
	"stash_empty":{"es":"Vacio","en":"Empty"},
	"menu_start_game":{"es":"Comenzar \nnueva aventura","en":"Start new adventure"},
	"menu_lang":{"es":"Idioma \nespanol","en":"Language \nenglish"},
	"menu_scale":{"es":"Escalado","en":"Scale "},
	
	"card_soldier_name":{"es":"Soldado","en":"Soldier"},
	"card_soldier_desc":{"es":"Invoca un soldado resistente para defenderte","en":"-"},
	"card_militia_name":{"es":"Milicia","en":"Warrior"},
	"card_militia_desc":{"es":"Invoca un guerrero para defenderte","en":"-"},
	"card_gold_name":{"es":"Oro","en":"Gold"},
	"card_gold_desc":{"es":"Ganas dos monedas de oro para usar en este turno","en":"-"},
	"card_market_name":{"es":"Mercado","en":"Market"},
	"card_market_desc":{"es":"Elige una entre tres cartas nuevas y agregala a tu descarte","en":"-"},
	"card_wind_name":{"es":"Viento","en":"Wind"},
	"card_wind_desc":{"es":"50/100 de impulsar a cada enemigo un casillero hacia atras","en":"-"},
	"card_teasure_name":{"es":"Tesoro","en":"Wind"},
	"card_teasure_desc":{"es":"Guarda una moneda en tu alijo. Puedes usarlas en cualquier turno","en":"-"},
	"card_house_name":{"es":"Casa","en":"House"},
	"card_house_desc":{"es":"Construye una casa cercana a tu fortaleza, cada casa da alojamiento a una unidad","en":"-"},
	"card_advance_name":{"es":"Avanzar","en":"Advance"},
	"card_advance_desc":{"es":"Eliges una unidad aliada para avanzar una casilla, si queda cerca de un enemigo lo ataca","en":"-"},
	"card_thundre_name":{"es":"Trueno","en":"Thundre"},
	"card_thundre_desc":{"es":"Un rayo de tormenta cae y golpea una unidad enemiga sin posibilidad de fallo","en":"-"},
	"card_chest_name":{"es":"Cofre","en":"Chest"},
	"card_chest_desc":{"es":"Descarta TODA tu mano y obtienes por cada carta exepto esta, una moneda para tu alijo ","en":"-"},
}

func get_string(code):
	return Texts[code][language]

func get_card_name(code):
	return Texts["card_"+code+"_name"][language]

func get_card_desc(code):
	return Texts["card_"+code+"_desc"][language]
