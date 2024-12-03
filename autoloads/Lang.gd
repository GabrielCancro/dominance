extends Node

var Texts = {
	"market":{"es":"Mercado","en":"Market"},
	"cost":{"es":"Costo","en":"Cost"},
	"select_unit_team_-1":{"es":"Elige una unidad","en":"Choose a unit"},
	"select_unit_team_1":{"es":"Elige un aliado","en":"Choose a ally"},
	"select_unit_team_2":{"es":"Elige un enemigo","en":"Choose a enemy"},
	"end_turn_button":{"es":"Finalizar Turno","en":"End Turn"},
	"discards_slot":{"es":"Descarte","en":"Discards"},
	"stash_empty":{"es":"Vacio","en":"Empty"},
	"menu_start_game":{"es":"Comenzar","en":"Start"},
	"menu_lang":{"es":"Idioma\nespanol","en":"Language\nenglish"},
	"menu_scale":{"es":"Escalado","en":"Scale "},
	"menu_fullscreen":{"es":"Pantalla\ncompleta","en":"Fullscreen"},
	"menu_credits":{"es":"Creditos","en":"Credits"},
	"menu_quit":{"es":"Salir","en":"Quit"},
	"menu_options":{"es":"Opciones","en":"Options"},
	"menu_upgrades":{"es":"Mejoras","en":"Upgrades"},
	"menu_invasion":{"es":"Invasión","en":"Invasion"},
	"lose_game":{"es":"Fuiste derrotado","en":"You were defeated"},
	"win_game":{"es":"Has resistido","en":"You have survived"},
	"exit_battle_title":{"es":"Abandonar partida","en":"Retreat from battle"},
	"exit_battle_text":{"es":"Si te retiras de esta batalla solo obtendras","en":"If you withdraw from this battle you will only get"},
	"exit_battle_continue":{"es":"Continuar jugando","en":"Continue playing"},
	"exit_battle_quit":{"es":"Abandonar partida","en":"Quit battle"},
	"title_clear_data":{"es":"Borrar datos","en":"Clear data"},
	"btn_yes":{"es":"Si","en":"Yes"},
	"btn_no":{"es":"No","en":"No"},
	"warning_clear_data":{
		"es":"Si borras los datos guardados perderas todos tus progresos y mejoras.\nEstas seguro de querer hacer esto?",
		"en":"If you delete your saved data you will lose all your progress and improvements.\nAre you sure you want to do this?"
	},
	"end_battle":{"es":"Batalla final","en":"Last Battle"},
	"endless_mode":{"es":"Sinfin","en":"Endless"},
	"ui_vol":{"es":"Volumen","en":"Volume"},
	
	"back_to_main":{"es":"Volver al menu","en":"Back to menu"},
	"start":{"es":"Comenzar","en":"Start"},
	"ok":{"es":"Ok","en":"Ok"},
	"points":{"es":"Puntos","en":"Points"},
	"upgrades":{"es":"Mejoras","en":"Upgrades"},
	"need_houses":{"es":"Faltan Casas","en":"Need Houses"},
	"max_houses":{"es":"Máximo Alcanzado","en":"Max Builded"},
	
	"card_soldier_name":{"es":"Soldado","en":"Soldier"},
	"card_soldier_desc":{"es":
		"Invoca un soldado resistente para defenderte",
		"en":"Summon a resilient soldier to defend you"},
	"card_militia_name":{"es":"Milicia","en":"Warrior"},
	"card_militia_desc":{
		"es":"Invoca un guerrero para defenderte",
		"en":"Summon a warrior to defend you"},
	"card_gold1_name":{"es":"Oro","en":"Gold"},
	"card_gold1_desc":{
		"es":"Ganas una moneda de oro para usar en este turno",
		"en":"You gain a gold coin to use this turn"},
	"card_gold2_name":{"es":"Oro","en":"Gold"},
	"card_gold2_desc":{
		"es":"Ganas dos monedas de oro para usar en este turno",
		"en":"You gain two gold coins to use this turn"},
	"card_market_name":{"es":"Mercado","en":"Market"},
	"card_market_desc":{
		"es":"Elige una entre tres cartas nuevas y agregala a tu descarte",
		"en":"Choose one of three new cards and add it to your discard"},
	"card_wind_name":{"es":"Viento","en":"Wind"},
	"card_wind_desc":{
		"es":"50 porciento de impulsar a cada enemigo un o dos casillero hacia atras",
		"en":"50 percent to push each enemy back one or two squares"},
	"card_teasure_name":{"es":"Tesoro","en":"Teasure"},
	"card_teasure_desc":{"es":
		"Guarda dos monedas en tu alijo. Puedes usarlas en cualquier turno",
		"en":"Keep two coins in your stash. You can use them on any turn"},
	"card_house_name":{"es":"Casa","en":"House"},
	"card_house_desc":{
		"es":"Construye una casa cercana a tu fortaleza, cada casa da alojamiento a una unidad",
		"en":"Build a house near your fortress, each house houses one unit"},
	"card_advance_name":{"es":"Avanzar","en":"Advance"},
	"card_advance_desc":{
		"es":"Eliges una unidad aliada para avanzar una casilla, si queda cerca de un enemigo lo ataca",
		"en":"You choose an allied unit to advance one square, if it is close to an enemy it attacks it"},
	"card_thundre_name":{"es":"Trueno","en":"Thundre"},
	"card_thundre_desc":{
		"es":"Un rayo de tormenta cae y golpea una unidad enemiga sin posibilidad de fallo",
		"en":"A storm bolt strikes and hits an enemy unit with no chance of miss"},
	"card_chest_name":{"es":"Cofre","en":"Chest"},
	"card_chest_desc":{"es":
		"Descarta TODA tu mano y obtienes por cada carta excepto esta, una moneda para tu alijo",
		"en":"Discard your ENTIRE hand and for each card except this one you get a coin for your stash"},
	"card_heal_name":{"es":"Sanar","en":"Heal"},
	"card_heal_desc":{"es":
		"Aumenta en un punto la vida a una de tus unidades",
		"en":"Increases the health of one of your units by one point"},
	"card_explode_name":{"es":"Explotar","en":"Explode"},
	"card_explode_desc":{
		"es":"Una fuerte explosion de fuego hire a un enemigo central y a cualquier unidad cercana a el",
		"en":"A strong explosion of fire hits a central enemy and any units near it"},
	"card_train_name":{"es":"Entrenar","en":"Train"},
	"card_train_desc":{
		"es":"Mejora una de tus milicias convitiendola en un soldado",
		"en":"Upgrade one of your militias by turning it into a soldier"},
	"card_torment_name":{"es":"Tormenta","en":"Torment"},
	"card_torment_desc":{
		"es":"Una secuencia de hasta tres truenos golpea a tres unidades enemigas diferentes",
		"en":"A sequence of up to three thunderclaps hits three different enemy units"},
	
	"upg_stash":{
		"es":"Empiezas la partida con cinco monedas en tu alijo",
		"en":"You start the game with five coins in your stash"},
	"upg_thundre_gold":{
		"es":"La carta de Trueno cuesta una moneda menos",
		"en":"Thunder card costs one coin less"},
	"upg_house":{
		"es":"Comienzas la partida con una casa extra ya edificada",
		"en":"You start the game with an extra house already built"},
	"upg_heal":{
		"es":"Se agrega una carta de curacion a tu mazo inicial",
		"en":"A heal card is added to your starting deck"},
	"upg_militia_gold":{
		"es":"La carta Milicia cuestan una moneda menos",
		"en":"The Militia card costs one coin less"},
	"upg_gold_five_days":{
		"es":"Obtienes una moneda directo a tu alijo cada cinco dias",
		"en":"You get a coin directly to your stash every five days"},
	"upg_market_gold":{
		"es":"La carta de Mercado cuesta una moneda menos",
		"en":"The Market card costs one coin less"},
	"upg_soldier_gold":{
		"es":"La carta de Soldado cuesta una moneda menos",
		"en":"The Soldier card costs one coin less"},
	"upg_magics":{
		"es":"Agrega las cartas Tormenta y Explotar al Mercado",
		"en":"Adds Storm and Explode cards to the Market"},
	"upg_train":{
		"es":"Agrega la carta Entrenar a tu mazo, esta carta te permite convertir milicias en soldados mas resistentes",
		"en":"Add the Train card to your deck, this card allows you to convert militias into more resistant soldiers"},
	
	"tutorial_1":{
		"es":"En cada turno recibes cinco cartas, cada una de ellas con efectos diferentes",
		"en":"On each turn you receive five cards, each of them with different effects"},
	"tutorial_2":{
		"es":"Para usar una carta debes pagar su coste en monedas de oro, puedes obtener monedas quemando las cartas que no utilices",
		"en":"To use a card you must pay its cost in gold coins, you can obtain coins by burning the cards you do not use"},
	"tutorial_3":{
		"es":"El objetivo es resistir el paso de los dias y eliminar a todos los enemigos",
		"en":"The objective is to resist the passing of the days and eliminate all enemies"},
	
	"tutorial_tower":{
		"es":"Bienvenido a dominance!\nEsta es tu torre. Tu objetivo es defenderla y cuidarla de los monstruos.",
		"en":"Welcome to dominance!\nThis is your tower. Your objective is to defend it and take care of it from monsters.",
	},
	"tutorial_gold":{
		"es":"Te ensñaré cómo.\n¿Ves esa carta de oro? Hazle click.",
		"en":"I'll show you how.\nSee that gold card? Click it.",
	},
	"tutorial_gold2":{
		"es":"Observa como haz ganado oro. El oro es la moneda de dominance. Con el puedes pagar todo!",
		"en":"See how you have earned gold. Gold is the currency of dominance. With it you can pay for everything!",
	},
	"tutorial_burn":{
		"es":"También puedes ganar oro quemando cartas que no nos sirvan en este momento. Ves esa carta de tesoro? Dale al icono de fuego en ella.",
		"en":"You can also earn gold by burning cards that are of no use to us at the moment. See that treasure card? Hit the fire icon on it.",
	},
	"tutorial_burn2":{
		"es":"Cuando quemas una carta ganas una moneda. Quema esa carta de viento tambien para que podamos tener 4 monedas.",
		"en":"When you burn a card you earn a coin. Burn that wind card too so we can have 4 coins.",
	},
	"tutorial_milician":{
		"es":"Ahora que tenemos 4 monedas podemos pagar para reclutar una milicia. Has clic en la carta de milicia.",
		"en":"Now that we have 4 coins we can pay to recruit a militia. Click on the militia card.",
	},
	"tutorial_turn":{
		"es":"Cuando no tengas mas cartas que jugar, dale a la hoguera para finalizar tu turno.",
		"en":"When you have no more cards to play, hit the bonfire to end your turn.",
	},
	"tutorial_enemies":{
		"es":"Un enemigo ha aparecido. Evita que llegue a tu torre.",
		"en":"An enemy has appeared. Prevent it from reaching your tower.",
	},
	"tutorial_days":{
		"es":"Listo Guerrero! Estás preparado para combatir las oleadas de monstruos. Protege la torre hasta que el verano llegue y lograrás la victoria.",
		"en":"Ready Warrior! You are ready to fight the waves of monsters. Protect the tower until summer comes and you will achieve victory.",
	},
	
	"end_battle_text":{
		"es":"Gracias por jugar Dominance! Puedes usar tus puntos de mejora para obtener beneficios.",
		"en":"Thank you for playing Dominance! You can use your upgrade points to gain benefits."},
	"end_demo_text":{
		"es":"Gracias por jugar al DEMO de DOMINANCE, fue un trabajo dificil pero estamos contentos de que lo disfrutes!\n\nNo dudes en adquirir la version completa del juego con mas cartas, niveles y sistema de mejoras!",
		"en":"Thank you for playing the DOMINANCE DEMO, it was a difficult job but we are glad you enjoyed it!\n\nDo not hesitate to purchase the full version of the game with more cards, levels and upgrade system!"},
}

func get_string(code):
	if !code in Texts: return code
	if !Saves.savedData.language in Texts[code]: return code+"_"+Saves.savedData.language
	return Texts[code][Saves.savedData.language]

func get_card_name(code):
	return Texts["card_"+code+"_name"][Saves.savedData.language]

func get_card_desc(code):
	return Texts["card_"+code+"_desc"][Saves.savedData.language]
