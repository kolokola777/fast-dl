// Stolen from HLSPClassicMode.as
bool ShouldRunSurvivalMode( const string& in szMapName )
{
	return szMapName != "cl_c00"
		and szMapName != "cl_c18";
}
