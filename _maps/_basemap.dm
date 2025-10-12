//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.
//#define ABSOLUTE_MINIMUM //uncomment this to load a smaller centcomm and smaller runtime station, only works together with LOWMEMORYMODE

#ifdef ABSOLUTE_MINIMUM
#define LOWMEMORYMODE
#endif

#ifndef ABSOLUTE_MINIMUM
#include "map_files\generic\CentCom.dmm"
#else
#include "map_files\generic\CentCom_minimal.dmm"
#endif

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		// TG Base Maps
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		#include "map_files\NebulaStation\NebulaStation.dmm"
		// Effigy Maps
		#include "effigy\map_files\FoxHoleStation\foxholestation.dmm"
		#include "effigy\map_files\RimPoint\RimPoint.dmm"
		#include "effigy\map_files\SigmaOctantis\SigmaOctantis.dmm"
	#endif
	#ifdef ALL_TEMPLATES
		#include "templates.dm"
	#endif
#endif
