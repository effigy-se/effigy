/obj/machinery/vending
	/// List of products to exclude when building the vending machine's inventory
	var/list/excluded_products
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_products
	/// Additions to the `product_categories` list of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_product_categories
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_premium
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_contraband

/obj/machinery/vending/Initialize(mapload)
	if(effigy_products)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in effigy_products)
			products[item_to_add] = effigy_products[item_to_add]

	if(effigy_product_categories)
		for(var/category in effigy_product_categories)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] |= category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += category

	if(effigy_premium)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in effigy_premium)
			premium[item_to_add] = effigy_premium[item_to_add]

	if(effigy_contraband)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in effigy_contraband)
			contraband[item_to_add] = effigy_contraband[item_to_add]

	remove_products(excluded_products)
	effigy_products = null
	effigy_product_categories = null
	effigy_premium = null
	effigy_contraband = null
	return ..()

/// Removes given list of products. Must be called before build_inventory() to actually prevent the records from being created.
/obj/machinery/vending/proc/remove_products(list/paths_to_remove)
	if(!length(paths_to_remove))
		return
	for(var/typepath in products)
		for(var/to_remove in paths_to_remove)
			if(ispath(typepath, to_remove))
				products.Remove(typepath)
