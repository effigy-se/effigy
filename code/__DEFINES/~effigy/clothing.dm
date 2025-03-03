/// Our parent type has digi support; but we don't either because we haven't been sprited for it or some other fuckery!
#define NO_DIGI_OR_SNOUT_VARIANT_HELPER(path) ##path {\
	supports_variations_flags = NONE; \
	supported_bodyshapes = null; \
	bodyshape_icon_files = null; \
}
