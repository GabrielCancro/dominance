extends Node

var language = "es"
var Texts = {
	"market":{"es":"Mercado","en":"Market"},
	
	"card_soldier_name":{"es":"Soldado","en":"Soldier"},
	"card_soldier_desc":{"es":"Invoca un soldado que defiende tu castillo","en":"-"},
	"card_warrior_name":{"es":"Guerrero","en":"Warrior"},
	"card_warrior_desc":{"es":"Esta es otra unidad diferente","en":"-"},
	"card_gold_name":{"es":"Gold","en":"Oro"},
	"card_gold_desc":{"es":"Ganas dos monedas de oro para usar en este turno","en":"-"},
	"card_market_name":{"es":"Mercado","en":"Market"},
	"card_market_desc":{"es":"Elige una entre tres cartas nuevas y agregala a tu descarte","en":"-"},
	"card_wind_name":{"es":"Viento","en":"Wind"},
	"card_wind_desc":{"es":"50% de impulsar a cada enemigo un casillero hacia atras","en":"-"},
}

func get_string(code):
	return Texts[code][language]

func get_card_name(code):
	return Texts["card_"+code+"_name"][language]

func get_card_desc(code):
	return Texts["card_"+code+"_desc"][language]
