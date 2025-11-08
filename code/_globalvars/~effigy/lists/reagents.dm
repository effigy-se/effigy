/// Similar to name2reagent list but contains only neuroware reagents.
GLOBAL_LIST_INIT(name2neuroware, build_name2neurowarelist())

/// Same as build_name2reagentlist() but contains only neuroware reagents.
/proc/build_name2neurowarelist()
	. = list()

	//build map with keys stored separately
	var/list/name_to_reagent = list()
	var/list/only_names = list()
	for (var/datum/reagent/reagent as anything in GLOB.chemical_reagents_list)
		if(reagent.chemical_flags & REAGENT_NEUROWARE_PACKAGE)
			var/name = initial(reagent.name)
			if (length(name))
				name_to_reagent[name] = reagent
				only_names += name

	//sort keys
	only_names = sort_list(only_names)

	//build map with sorted keys
	for(var/name in only_names)
		.[name] = name_to_reagent[name]
