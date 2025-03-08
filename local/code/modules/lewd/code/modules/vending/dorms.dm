/obj/machinery/vending/dorms
	name = "\improper Keepsake Enticements"
	desc = "A vending machine filled with various adult toys and accessories."
	icon_state = "dorms"
	base_icon_state = "dorms_vendor"
	icon = 'local/icons/lewd/obj/machines/vending.dmi'
	light_mask = "dorms-light-mask"
	age_restrictions = TRUE
	product_ads = "Long Night?;Some spice for your intimacy!;Make the memory last."
	vend_reply = "Thank you for choosing Keepsake!"
	panel_type = "dorms-panel"

	product_categories = list(
		list(
			"name" = "Fashion",
			"icon" = FA_ICON_SHIRT,
			"products" = list(
				/// Collars
				// Thin
				/obj/item/clothing/neck/collar = 4,
				/obj/item/clothing/neck/collar/bell = 4,
				/obj/item/clothing/neck/collar/cowbell = 4,
				/obj/item/clothing/neck/collar/cross = 4,
				/obj/item/clothing/neck/collar/tagged = 4,
				// Thick
				/obj/item/clothing/neck/collar/thick = 4,
				/obj/item/clothing/neck/collar/thick/bell = 4,
				/obj/item/clothing/neck/collar/thick/cowbell = 4,
				/obj/item/clothing/neck/collar/thick/cross = 4,
				/obj/item/clothing/neck/collar/thick/tagged = 4,
				// Leather
				/obj/item/clothing/neck/collar/leather = 4,
				/obj/item/clothing/neck/collar/leather/bell = 4,
				/obj/item/clothing/neck/collar/leather/cowbell = 4,
				/obj/item/clothing/neck/collar/leather/cross = 4,
				/obj/item/clothing/neck/collar/leather/tagged = 4,
				/// Belts
				/obj/item/storage/belt/thigh_satchel = 4,
			),
		),
		list(
			"name" = "Restraints",
			"icon" = FA_ICON_HANDCUFFS,
			"products" = list(
				/obj/item/restraints/handcuffs/fake = 2,
				/obj/item/clothing/glasses/blindfold = 4,
				/obj/item/clothing/glasses/blindfold/dorms = 4,
				/obj/item/clothing/mask/muzzle = 4,
			),
		),
		list(
			"name" = "Tools",
			"icon" = FA_ICON_TOOLBOX,
			"products" = list(
				/obj/item/clothing/erp_leash = 8,
				/obj/item/clothing/glasses/hypno = 4,
			),
		),
	)

	premium = list(
		/obj/item/clothing/neck/collar/holocollar = 3,
		/obj/item/clothing/neck/collar/thick/holocollar = 3,
		/obj/item/clothing/neck/collar/leather/holocollar = 3,
		)

	contraband = list(/obj/item/toy/plush/shark = 1) // temp

	refill_canister = /obj/item/vending_refill/dorms
	payment_department = ACCOUNT_SRV
	default_price = PAYCHECK_CREW * 0.6
	extra_price = PAYCHECK_COMMAND * 2.5

/obj/machinery/vending/dorms/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		new /obj/item/kirbyplants/random(get_turf(src))
		return INITIALIZE_HINT_QDEL

//Refill item
/obj/item/vending_refill/dorms
	machine_name = "Keepsake Enticements"
	icon_state = "refill_dorms"
	icon = 'local/icons/obj/vending_restock.dmi'

/obj/item/vending_refill/dorms/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_lewd_items))
		new /obj/item/vending_refill/cola(get_turf(src))
		return INITIALIZE_HINT_QDEL
