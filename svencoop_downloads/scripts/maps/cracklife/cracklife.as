// Crack-Life Stuff
#include "weapons/weapons"
#include "weapons/mappings"

// HLSP Stuff
#include "../hlsp/trigger_suitcheck"
#include "../point_checkpoint"

// Survival
#include "survmode"

#include "../cubemath/trigger_once_mp"
#include "../cubemath/polling_check_players"

// Crack-Life mode.
// True: Original
// False: Campaign Mode
const bool g_bCrackLifeMode = true;

void MapInit()
{
	// HLSP Stuff
	RegisterTriggerSuitcheckEntity();
	RegisterPointCheckPointEntity();
        RegisterTriggerOnceMpEntity();
        g_EngineFuncs.CVarSetFloat( "mp_hevsuit_voice", 1 );

	//Crack-Life
	RegisterCrackLifeWeapons();

	// Initialize classic mode (item mapping only)
	g_ClassicMode.SetItemMappings( @g_ItemMappings );
	g_ClassicMode.ForceItemRemap( true );

	// Map support is enabled here by default.
	// So you don't have to add "mp_survival_supported 1" to the map config
	if( ShouldRunSurvivalMode( g_Engine.mapname ) )
		g_SurvivalMode.EnableMapSupport();
        poll_check();
}
