// PRISONER
/datum/armor/clothing_under/red_sec
	melee = 10
	bio = 10
	fire = 30
	acid = 30
	wound = 10

/obj/item/clothing/under/rank/prisoner/protcust
	name = "protective custody prisoner jumpsuit"
	desc = "A mustard coloured prison jumpsuit, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/skirt/protcust
	name = "protective custody prisoner jumpskirt"
	desc = "A mustard coloured prison jumpskirt, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FFB600"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/lowsec
	name = "low security prisoner jumpsuit"
	desc = "A pale, almost creamy prison jumpsuit, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/skirt/lowsec
	name = "low security prisoner jumpskirt"
	desc = "A pale, almost creamy prison jumpskirt, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#AB9278"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/highsec
	name = "high risk prisoner jumpsuit"
	desc = "A bright red prison jumpsuit, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/skirt/highsec
	name = "high risk prisoner jumpskirt"
	desc = "A bright red prison jumpskirt, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FF3400"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/supermax
	name = "supermax prisoner jumpsuit"
	desc = "A dark crimson red prison jumpsuit, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/skirt/supermax
	name = "supermax prisoner jumpskirt"
	desc = "A dark crimson red prison jumpskirt, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#992300"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/lustwish
	desc = "A customizable prisoner-style jumpsuit for the truly debaucherous. It has LustWish's signature logo stitched into the tag."
	greyscale_colors = "#4B4669"
	has_sensor = /obj/item/clothing/under::has_sensor
	sensor_mode = /obj/item/clothing/under::sensor_mode
	random_sensor = /obj/item/clothing/under::random_sensor
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/rank/prisoner/skirt/lustwish
	desc = "A customizable prisoner-style jumpskirt for the truly debaucherous. It has LustWish's signature logo stitched into the tag."
	greyscale_colors = "#4B4669"
	has_sensor = /obj/item/clothing/under::has_sensor
	sensor_mode = /obj/item/clothing/under::sensor_mode
	random_sensor = /obj/item/clothing/under::random_sensor
	flags_1 = /obj/item/clothing/under/rank/prisoner/lustwish::flags_1
	supports_variations_flags = NONE
