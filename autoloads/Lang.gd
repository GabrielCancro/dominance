extends Node

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
	"lose_game":{"es":"Fuiste derrotado","en":"You were defeated "},
	"back_to_main":{"es":"Volver al menu","en":"Back to menu"},
	"start":{"es":"Comenzar","en":"Start"},
	"points":{"es":"Puntos","en":"Points"},
	"upgrades":{"es":"Mejoras","en":"Upgrades"},
	
	"card_soldier_name":{"es":"Soldado","en":"Soldier"},
	"card_soldier_desc":{"es":
		"Invoca un soldado resistente para defenderte",
		"en":"-"},
	"card_militia_name":{"es":"Milicia","en":"Warrior"},
	"card_militia_desc":{
		"es":"Invoca un guerrero para defenderte",
		"en":"-"},
	"card_gold1_name":{"es":"Oro","en":"Gold"},
	"card_gold1_desc":{
		"es":"Ganas una moneda de oro para usar en este turno",
		"en":"-"},
	"card_gold2_name":{"es":"Oro","en":"Gold"},
	"card_gold2_desc":{
		"es":"Ganas dos monedas de oro para usar en este turno",
		"en":"-"},
	"card_market_name":{"es":"Mercado","en":"Market"},
	"card_market_desc":{
		"es":"Elige una entre tres cartas nuevas y agregala a tu descarte",
		"en":"-"},
	"card_wind_name":{"es":"Viento","en":"Wind"},
	"card_wind_desc":{"es":
		"50/100 de impulsar a cada enemigo un casillero hacia atras",
		"en":"-"},
	"card_teasure_name":{"es":"Tesoro","en":"Teasure"},
	"card_teasure_desc":{"es":
		"Guarda una moneda en tu alijo. Puedes usarlas en cualquier turno",
		"en":"-"},
	"card_house_name":{"es":"Casa","en":"House"},
	"card_house_desc":{
		"es":"Construye una casa cercana a tu fortaleza, cada casa da alojamiento a una unidad",
		"en":"-"},
	"card_advance_name":{"es":"Avanzar","en":"Advance"},
	"card_advance_desc":{
		"es":"Eliges una unidad aliada para avanzar una casilla, si queda cerca de un enemigo lo ataca",
		"en":"-"},
	"card_thundre_name":{"es":"Trueno","en":"Thundre"},
	"card_thundre_desc":{
		"es":"Un rayo de tormenta cae y golpea una unidad enemiga sin posibilidad de fallo",
		"en":"-"},
	"card_chest_name":{"es":"Cofre","en":"Chest"},
	"card_chest_desc":{"es":
		"Descarta TODA tu mano y obtienes por cada carta exepto esta, una moneda para tu alijo ",
		"en":"-"},

	"upgrade_upg1":{
		"es":"Empiezas la partida con cinco monedas en tu alijo",
		"en":"Desc"},
	"upgrade_upg2":{
		"es":"La carta de trueno cuesta una moneda menos",
		"en":"Desc"},
	"upgrade_upg3":{
		"es":"Comienzas la partida con una casa extra ya edificada",
		"en":"Desc"},
	"upgrade_upg4":{
		"es":"se agrega una carta de curacion a tu mazo inicial ",
		"en":"Desc"},
	"upgrade_upg5":{
		"es":"La carta milicia cuestan una moneda menos",
		"en":"Desc"},
	"upgrade_upg6":{
		"es":"Obtienes una moneda directo a tu alijo cada cinco dias",
		"en":"Desc"},
	"upgrade_upg7":{
		"es":"Aún no sabemos que hace esto",
		"en":"Desc"},
	"upgrade_upg8":{
		"es":"Aún no sabemos que hace esto",
		"en":"Desc"},
	
	"tutorial_1":{
		"es":"En cada turno recibes cinco cartas, cada una de ellas con efectos diferentes",
		"en":"On each turn you receive five cards, each of them with different effects"},
	"tutorial_2":{
		"es":"Para usar una carta debes pagar su coste en monedas de oro, puedes obtener monedas quemando las cartas que no utilices",
		"en":"To use a card you must pay its cost in gold coins, you can obtain coins by burning the cards you do not use"},
	"tutorial_3":{
		"es":"El objetivo es resistir durante 60 dias y eliminar a todos los enemigos",
		"en":"The objective is to resist for 60 days and eliminate all enemies"},
}

func get_string(code):
	return Texts[code][Saves.savedData.language]

func get_card_name(code):
	return Texts["card_"+code+"_name"][Saves.savedData.language]

func get_card_desc(code):
	return Texts["card_"+code+"_desc"][Saves.savedData.language]
