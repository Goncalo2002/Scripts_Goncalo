petrolCanPrice = 1

lang = "en"
-- lang = "fr"

settings = {}
settings["en"] = {
	openMenu = "Pressiona ~g~E~w para abrir o menu.",
	electricError = "~r~Tas a conduzir um carro eletrico.",
	fuelError = "~r~Nao tas no sitio certo.",
	buyFuel = "Comprar Combustivel",
	liters = "Litros",
	percent = "Percentagem",
	confirm = "Confirmar",
	fuelStation = "Bomba Gasolina",
	boatFuelStation = "Bomba dos Barcos",
	avionFuelStation = "Bomba dos Avioes",
	heliFuelStation = "Bomba dos Heli",
	getJerryCan = "Pressiona ~g~E~w~ para comprar lata (€"..petrolCanPrice..")",
	refeel = "Pressiona ~g~E~w~ para encher.",
	YouHaveBought = "Compraste ",
	fuel = " Litros de Combustivel",
	price = "Preço"
}

settings["fr"] = {
	openMenu = "Appuyez sur ~g~E~w~ pour ouvrir le menu.",
	electricError = "~r~Vous avez une voiture électrique.",
	fuelError = "~r~Vous n'êtes pas au bon endroit.",
	buyFuel = "acheter de l'essence",
	liters = "litres",
	percent = "pourcent",
	confirm = "Valider",
	fuelStation = "Station essence",
	boatFuelStation = "Station d'essence | Bateau",
	avionFuelStation = "Station d'essence | Avions",
	heliFuelStation = "Station d'essence | Hélicoptères",
	getJerryCan = "Appuyez sur ~g~E~w~ pour acheter un bidon d'essence ("..petrolCanPrice.."€)",
	refeel = "Appuyez sur ~g~E~w~ pour remplir votre voiture d'essence.",
	YouHaveBought = "Vous avez acheté ",
	fuel = " litres d'essence",
	price = "prix"
}


showBar = true
showText = true


hud_form = 2 -- 1 : Vertical | 2 = Horizontal
hud_x = 0.087
hud_y = 0.770

text_x = 0.000
text_y = 0.000


electricityPrice = 3 -- NOT RANOMED !!
petrolCanPrice = 20
randomPrice = false --Random the price of each stations
price = 2 --If random price is on False, set the price here for 1 liter