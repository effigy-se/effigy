/proc/prefix_a_or_an(text)
	var/first_letter = LOWER_TEXT(text[1])
	if(!first_letter)
		return "a"
	if(first_letter == "a" || first_letter == "e" || first_letter == "i" || first_letter == "o" || first_letter == "u")
		return "an"
	else
		return "a"
