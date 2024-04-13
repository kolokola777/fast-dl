string g_lpszModelFloorDefault;
string g_lpszModelFloorVote;
string g_lpszModelWallDefault;
string g_lpszModelWallVote;

string g_lpszModelFloorTheyHungerVote;
string g_lpszModelFloorWithCeilingTheyHungerVote;
string g_lpszModelWallTheyHungerVote;
string g_lpszModelEnclosingWallTheyHunger;
string g_lpszModelDefaultWallTheyHunger;
string g_lpszModelFloorAndSnowTheyHungerVote;
string g_lpszModelFloorWithCeilingAndSnowTheyHungerVote;

bool g_bEnableEventModes = true;

bool g_bForceHalloweenMode = false;
bool g_bForceXMasMode = false;

int g_iEventTestMonth = -1;

int GetMonth() {
    if (g_iEventTestMonth != -1)
        return g_iEventTestMonth;
        
    return DateTime().GetMonth();
}

bool g_bHalloweenMode = g_bForceHalloweenMode || (g_bEnableEventModes && GetMonth() == 10);
bool g_bEnableSnow = g_bForceXMasMode || (g_bEnableEventModes && (GetMonth() >= 11 || GetMonth() == 1));

array<string> g_rgszModelsTheyHungerWallsCurved;
int g_iTheyHungerWallIdx = 0;

EHandle g_hTheyHungerTree;
string g_lpszModelTheyHungerXMasSnow;

void AddDefaultWallTheyHunger(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelDefaultWallTheyHunger);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddWallTheyHunger(int _X, int _Y) {
    if (g_iTheyHungerWallIdx > 3)
        g_iTheyHungerWallIdx = 0;
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_rgszModelsTheyHungerWallsCurved[g_iTheyHungerWallIdx]);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
    g_iTheyHungerWallIdx++;
}

string g_lpszModelTheyHungerFloor1;
string g_lpszModelTheyHungerFloor2;
string g_lpszModelTheyHungerFloor3;
string g_lpszModelTheyHungerFloorAndSnow1;
string g_lpszModelTheyHungerFloorAndSnow2;
string g_lpszModelTheyHungerFloorAndSnow3;

void AddFloorTheyHungerFirst(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_bEnableSnow ? g_lpszModelTheyHungerFloorAndSnow1 : g_lpszModelTheyHungerFloor1);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddFloorTheyHungerSecond(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_bEnableSnow ? g_lpszModelTheyHungerFloorAndSnow2 : g_lpszModelTheyHungerFloor2);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddFloorTheyHungerThird(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_bEnableSnow ? g_lpszModelTheyHungerFloorAndSnow3 : g_lpszModelTheyHungerFloor3);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

string g_lpszModelTheyHungerCeiling;

void AddCeilingTheyHunger(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640 - ((g_bHalloweenMode || g_rgnScaryIndexes.length() == g_rgszFirstMap.length()) ? 32 : 0), _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelTheyHungerCeiling);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

string g_lpszModelTheyHungerFloorWithCeiling1;
string g_lpszModelTheyHungerFloorWithCeiling2;
string g_lpszModelTheyHungerFloorWithCeiling3;
string g_lpszModelTheyHungerFloorWithCeilingAndSnow1;
string g_lpszModelTheyHungerFloorWithCeilingAndSnow2;
string g_lpszModelTheyHungerFloorWithCeilingAndSnow3;

void AddFloorWithCeilingTheyHungerFirst(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_bEnableSnow ? g_lpszModelTheyHungerFloorWithCeilingAndSnow1 : g_lpszModelTheyHungerFloorWithCeiling1);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
    AddCeilingTheyHunger(_X, _Y);
}

void AddFloorWithCeilingTheyHungerSecond(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_bEnableSnow ? g_lpszModelTheyHungerFloorWithCeilingAndSnow2 : g_lpszModelTheyHungerFloorWithCeiling2);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
    AddCeilingTheyHunger(_X, _Y);
}

void AddFloorWithCeilingTheyHungerThird(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_bEnableSnow ? g_lpszModelTheyHungerFloorWithCeilingAndSnow3 : g_lpszModelTheyHungerFloorWithCeiling3);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
    AddCeilingTheyHunger(_X, _Y);
}

void AddWallVoteTheyHunger(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelWallTheyHungerVote);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddFloorVoteTheyHunger(int _X, int _Y, bool _HasCeiling) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_bEnableSnow ? (_HasCeiling ? g_lpszModelFloorWithCeilingAndSnowTheyHungerVote : g_lpszModelFloorAndSnowTheyHungerVote) : (_HasCeiling ? g_lpszModelFloorWithCeilingTheyHungerVote : g_lpszModelFloorTheyHungerVote));
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddEnclosingCeilingTheyHungerWindowWall(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X - 640 - ((g_bHalloweenMode || g_rgnScaryIndexes.length() == g_rgszFirstMap.length()) ? 32 : 0), _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelEnclosingWallTheyHunger);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddSnow(int _X, int _Y) {
    if (!g_bEnableSnow) return;

    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_conveyor", Vector(_X - 640, _Y, 2048), g_vecZero, true);
    lpWall.pev.rendermode = kRenderTransAdd;
    lpWall.pev.renderamt = 255;
    lpWall.pev.solid = SOLID_NOT;
    g_EntityFuncs.SetModel(lpWall, g_lpszModelTheyHungerXMasSnow);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

string g_model_ascii_error;
array<string> g_model_ascii;
array<string> g_rgszCampaignSprites;
array<string> g_rgszBootCampMap;
array<string> g_rgszFirstMap;
array<string> g_rgszSecondMap;
int g_iTimeLeftToVote;
int g_iTimeToVote;
int g_nCurrentlySelectedMap;
array<int> g_rgnScaryIndexes;

bool IsIndexScary(int _Which) {
    if (g_bHalloweenMode) return true;

    for (uint idx = 0; idx < g_rgnScaryIndexes.length(); idx++) {
        if (g_rgnScaryIndexes[idx] == _Which)
            return true;
    }
    
    return false;
}

void AddWallDefault(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelWallDefault);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddWallVote(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelWallVote);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddFloorDefault(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelFloorDefault);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void AddFloorVote(int _X, int _Y) {
    CBaseEntity@ lpWall = g_EntityFuncs.Create("func_wall", Vector(_X, _Y, 2048), g_vecZero, true);
    g_EntityFuncs.SetModel(lpWall, g_lpszModelFloorVote);
    g_EntityFuncs.DispatchSpawn(lpWall.edict());
}

void ParseCampaignListFile() {
    File@ lpFile = g_FileSystem.OpenFile("scripts/maps/store/mapvote_maps.txt", OpenFile::READ);

    if (lpFile is null || !lpFile.IsOpen()) {
        g_rgszCampaignSprites.resize(1);
        g_rgszFirstMap.resize(1);
        g_rgszSecondMap.resize(1);
        g_rgszBootCampMap.resize(1);
        
        g_rgszCampaignSprites[0] = "";
        g_rgszFirstMap[0] = "hl_c00";
        g_rgszSecondMap[0] = "hl_c02_a1";
        g_rgszBootCampMap[0] = "hl_t00";
        return;
    }
    
    string szLine;
    int nLineIdx = 0;
    g_iTimeLeftToVote = -1;
    
    while (!lpFile.EOFReached()) {
        lpFile.ReadLine(szLine);
        
        if (szLine.Length() < 1) continue;
        
        if (g_iTimeLeftToVote < 0) {
            if (szLine.Find("Time: ") == 0) {
                g_iTimeLeftToVote = atoi(szLine.SubString(6));
            }
            
            if (g_iTimeLeftToVote < 0) {
                g_iTimeLeftToVote = 30;
            } else {
                continue;
            }
        }
        
        int splitter1 = -1;
        int splitter2 = -1;
        int splitter3 = -1;
        int splitter4 = -1;
        bool bEscapeMode = false;
        
        for (uint i = 0; i < szLine.Length(); i++) {
            if (szLine[i] == "\\") {
                if (bEscapeMode) {
                    for (uint j = i; j < szLine.Length() - 1; j++) {
                        szLine.SetCharAt(j, szLine[j + 1]);
                    }
                    szLine = szLine.SubString(0, szLine.Length() - 1);
                    i--;
                    bEscapeMode = false;
                } else {
                    bEscapeMode = true;
                }
            } else if (szLine[i] == "n") {
                if (bEscapeMode) {
                    szLine.SetCharAt(i - 1, char('\n'));
                    for (uint j = i; j < szLine.Length() - 1; j++) {
                        szLine.SetCharAt(j, szLine[j + 1]);
                    }
                    szLine = szLine.SubString(0, szLine.Length() - 1);
                    i--;
                    bEscapeMode = false;
                }
            } else if (szLine[i] == "|") {
                if (bEscapeMode) {
                    szLine.SetCharAt(i - 1, char('|'));
                    for (uint j = i; j < szLine.Length() - 1; j++) {
                        szLine.SetCharAt(j, szLine[j + 1]);
                    }
                    szLine = szLine.SubString(0, szLine.Length() - 1);
                    i--;
                    bEscapeMode = false;
                } else if (splitter1 == -1) {
                    splitter1 = i;
                } else if (splitter2 == -1) {
                    splitter2 = i;
                }
            } else if (szLine[i] == "+") {
                if (splitter4 == -1) {
                    splitter4 = i;
                }
            } else if (szLine[i] == "=") {
                if (splitter3 == -1) {
                    splitter3 = i;
                }
            } else {
                bEscapeMode = false;
            }
        }
        
        if (splitter1 != -1 && szLine.SubString(0, splitter1).Length() > 4 && szLine.SubString(splitter1 - 4, 4) == ".spr") {
            if (splitter2 != -1) {
                g_rgszCampaignSprites.resize(g_rgszCampaignSprites.size() + 1);
                g_rgszFirstMap.resize(g_rgszFirstMap.size() + 1);
                g_rgszSecondMap.resize(g_rgszSecondMap.size() + 1);
                g_rgszBootCampMap.resize(g_rgszBootCampMap.size() + 1);
                
                g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1] = szLine.SubString(0, splitter1);
                
                if (g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1].Length() > 0) {
                    g_Game.PrecacheModel(g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1]);
                    g_Game.PrecacheGeneric(g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1]);
                }
                
                if (splitter3 != -1) {
                    if (splitter4 != -1) {
                        g_rgszBootCampMap[g_rgszBootCampMap.size() - 1] = szLine.SubString(splitter3 + 1, splitter4 - splitter3 - 1);
                    } else {
                        g_rgszBootCampMap[g_rgszBootCampMap.size() - 1] = szLine.SubString(splitter3 + 1);
                    }
                }
                
                if (splitter2 != -1) {
                    g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1, splitter2 - splitter1 - 1);
                    if (splitter3 != -1) {
                        g_rgszSecondMap[g_rgszSecondMap.size() - 1] = szLine.SubString(splitter2 + 1, splitter3 - splitter2 - 1);
                    } else {
                        if (splitter4 != -1) {
                            g_rgszSecondMap[g_rgszSecondMap.size() - 1] = szLine.SubString(splitter2 + 1, splitter4 - splitter2 - 1);
                        } else {
                            g_rgszSecondMap[g_rgszSecondMap.size() - 1] = szLine.SubString(splitter2 + 1);
                        }
                    }
                } else {
                    g_rgszSecondMap[g_rgszSecondMap.size() - 1] = "";
                    if (splitter4 != -1) {
                        g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1, splitter4 - splitter1 - 1);
                    } else {
                        g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1);
                    }
                }
                
                if (splitter4 != -1) {
                    string szScaryYesOrNo = szLine.SubString(splitter4 + 1);
                    if (szScaryYesOrNo.ToLowercase() == "yes") {
                        g_rgnScaryIndexes.insertLast(nLineIdx - 1);
                    }
                }
            } else {
                g_rgszCampaignSprites.resize(g_rgszCampaignSprites.size() + 1);
                g_rgszFirstMap.resize(g_rgszFirstMap.size() + 1);
                g_rgszSecondMap.resize(g_rgszSecondMap.size() + 1);
                g_rgszBootCampMap.resize(g_rgszBootCampMap.size() + 1);
                
                g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1] = szLine.SubString(0, splitter1);
                
                if (g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1].Length() > 0) {
                    g_Game.PrecacheModel(g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1]);
                    g_Game.PrecacheGeneric(g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1]);
                }
                
                if (splitter4 != -1) {
                    g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1, splitter4 - splitter1 - 1);
                } else {
                    g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1);
                }
                
                if (splitter4 != -1) {
                    string szScaryYesOrNo = szLine.SubString(splitter4 + 1);
                    if (szScaryYesOrNo.ToLowercase() == "yes") {
                        g_rgnScaryIndexes.insertLast(nLineIdx - 1);
                    }
                }
            }
        } else {
            if (splitter1 != -1) {
                g_rgszCampaignSprites.resize(g_rgszCampaignSprites.size() + 1);
                g_rgszBootCampMap.resize(g_rgszBootCampMap.size() + 1);
                g_rgszFirstMap.resize(g_rgszFirstMap.size() + 1);
                g_rgszSecondMap.resize(g_rgszSecondMap.size() + 1);
                
                g_rgszCampaignSprites[g_rgszCampaignSprites.size() - 1] = "";
                
                if (splitter3 != -1) {
                    if (splitter4 != -1) {
                        g_rgszBootCampMap[g_rgszBootCampMap.size() - 1] = szLine.SubString(splitter3 + 1, splitter4 - splitter3 - 1);
                    } else {
                        g_rgszBootCampMap[g_rgszBootCampMap.size() - 1] = szLine.SubString(splitter3 + 1);
                    }
                }
                
                if (splitter2 != -1) {
                    g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1, splitter2 - splitter1 - 1);
                    if (splitter3 != -1) {
                        g_rgszSecondMap[g_rgszSecondMap.size() - 1] = szLine.SubString(splitter2 + 1, splitter3 - splitter2 - 1);
                    } else {
                        if (splitter4 != -1) {
                            g_rgszSecondMap[g_rgszSecondMap.size() - 1] = szLine.SubString(splitter2 + 1, splitter4 - splitter2 - 1);
                        } else {
                            g_rgszSecondMap[g_rgszSecondMap.size() - 1] = szLine.SubString(splitter2 + 1);
                        }
                    }
                } else {
                    g_rgszSecondMap[g_rgszSecondMap.size() - 1] = "";
                    if (splitter4 != -1) {
                        g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1, splitter4 - splitter1 - 1);
                    } else {
                        g_rgszFirstMap[g_rgszFirstMap.size() - 1] = szLine.SubString(splitter1 + 1);
                    }
                }
                
                if (splitter4 != -1) {
                    string szScaryYesOrNo = szLine.SubString(splitter4 + 1);
                    if (szScaryYesOrNo.ToLowercase() == "yes") {
                        g_rgnScaryIndexes.insertLast(nLineIdx - 1);
                    }
                }
            }
        }
        
        nLineIdx++;
    }
    
    g_iTimeToVote = g_iTimeLeftToVote;
    g_nCurrentlySelectedMap = -1;
    
    if (g_rgszFirstMap.size() < 1) {
        g_rgszCampaignSprites.resize(1);
        g_rgszBootCampMap.resize(1);
        g_rgszFirstMap.resize(1);
        g_rgszSecondMap.resize(1);
        
        g_rgszCampaignSprites[0] = "";
        g_rgszBootCampMap[0] = "hl_t00";
        g_rgszFirstMap[0] = "hl_c00";
        g_rgszSecondMap[0] = "hl_c02_a1";
    }
    
    lpFile.Close();
}

void StartSkipIntroVote() {
    Vote vote("Skip-Vote", "Skip Intro", 10.f, 50.1f);
    vote.SetYesText("Yes (" + g_rgszSecondMap[g_nCurrentlySelectedMap] + ")");
    vote.SetNoText("No (" + g_rgszFirstMap[g_nCurrentlySelectedMap] + ")");
    vote.SetVoteBlockedCallback(@SkipIntroVoteBlockedCB);
    vote.SetVoteEndCallback(@SkipIntroVoteEndCB);
    
    vote.Start();
}

void StartBootCampVote() {
    Vote vote("BootCamp-Vote", "Play Boot-Camp?", 10.f, 50.1f);
    vote.SetYesText("Yes (" + g_rgszBootCampMap[g_nCurrentlySelectedMap] + ")");
    vote.SetNoText("No (Start skip intro vote)");
    vote.SetVoteBlockedCallback(@BootCampVoteBlockedCB);
    vote.SetVoteEndCallback(@BootCampVoteEndCB);
    
    vote.Start();
}

void BootCampVoteBlockedCB(Vote@ _Vote, float _Time) {
    g_Scheduler.SetTimeout("StartBootCampVote", 1.0f);
}

void BootCampVoteEndCB(Vote@ _Vote, bool _Result, int _Voters) {
    if (!_Result || _Voters == 0) {
        g_Scheduler.SetTimeout("StartSkipIntroVote", 1.0f);
        return;
    }
    
    g_EngineFuncs.ChangeLevel(g_rgszBootCampMap[g_nCurrentlySelectedMap]);
    g_Scheduler.SetTimeout("NotifyMapNotFound", 1.0f, g_rgszBootCampMap[g_nCurrentlySelectedMap]);
}

void SkipIntroVoteBlockedCB(Vote@ _Vote, float _Time) {
    g_Scheduler.SetTimeout("StartSkipIntroVote", 1.0f);
}

void SkipIntroVoteEndCB(Vote@ _Vote, bool _Result, int _Voters) {
    if (!_Result || _Voters == 0) {
        g_EngineFuncs.ChangeLevel(g_rgszFirstMap[g_nCurrentlySelectedMap]);
        g_Scheduler.SetTimeout("NotifyMapNotFound", 1.0f, g_rgszFirstMap[g_nCurrentlySelectedMap]);
        return;
    }
    
    g_EngineFuncs.ChangeLevel(g_rgszSecondMap[g_nCurrentlySelectedMap]);
    g_Scheduler.SetTimeout("NotifyMapNotFound", 1.0f, g_rgszSecondMap[g_nCurrentlySelectedMap]);
}

void ChangeToFirstSpecifiedMap() {
    g_EngineFuncs.ChangeLevel(g_rgszFirstMap[g_nCurrentlySelectedMap]);
    g_Scheduler.SetTimeout("NotifyMapNotFound", 1.0f, g_rgszFirstMap[g_nCurrentlySelectedMap]);
}

void NotifyMapNotFound(const string& in _MapName) {
    HUDTextParams hudParams;
    hudParams.x = -1.0f;
    hudParams.y = 0.7;
    hudParams.r1 = 255;
    hudParams.g1 = 0;
    hudParams.b1 = 0;
    hudParams.r2 = 255;
    hudParams.g2 = 0;
    hudParams.b2 = 0;
    hudParams.effect = 0;
    hudParams.fadeinTime = 0.0f;
    hudParams.fadeoutTime = 0.80f;
    hudParams.holdTime = 2.0f;
    hudParams.channel = 1;
    
    g_Scheduler.SetTimeout("CheckersThink", 3.0f);
    
    g_PlayerFuncs.HudMessageAll(hudParams, "ERROR! Map not found: " + _MapName);

    g_iTimeLeftToVote = g_iTimeToVote;
}

void CheckersThink() {
    HUDTextParams hudParams;
    hudParams.x = -1.0f;
    hudParams.y = 0.85f;
    hudParams.r1 = 255;
    hudParams.g1 = 255;
    hudParams.b1 = 255;
    hudParams.r2 = 255;
    hudParams.g2 = 255;
    hudParams.b2 = 255;
    hudParams.effect = 0;
    hudParams.fadeinTime = 0.0f;
    hudParams.fadeoutTime = 0.45f;
    hudParams.holdTime = 1.05f;
    hudParams.channel = 1;
    
    uint iRoomSize = g_rgszFirstMap.size();
    array<int> aiVoters;
    aiVoters.resize(iRoomSize);
    int nTotalVoters = 0;
    
    for (int idx = 1; idx <= g_Engine.maxClients; ++idx) {
        CBasePlayer@ lpPlayer = g_PlayerFuncs.FindPlayerByIndex(idx);
        
        if (lpPlayer is null || !lpPlayer.IsConnected()) 
            continue;
        
        if (!g_bHalloweenMode && g_rgnScaryIndexes.length() != g_rgszFirstMap.length()) {
            lpPlayer.pev.renderfx = kRenderFxGlowShell;
            lpPlayer.pev.rendermode = kRenderTransAdd;
            lpPlayer.pev.renderamt = 255;
        }
        
        if (lpPlayer.pev.origin.y < 640 || lpPlayer.pev.origin.y > 896)
            continue;
        
        int iRelativeX = int(lpPlayer.pev.origin.x) + 128 * iRoomSize;
        int arrayIndex = iRelativeX / 256;
        
        if (iRelativeX < 0 || arrayIndex >= int(iRoomSize))
            continue;
        
        nTotalVoters++;
        aiVoters[arrayIndex]++;
    }
    
    if (nTotalVoters == 0) {
        g_iTimeLeftToVote = g_iTimeToVote;
        g_Scheduler.SetTimeout("CheckersThink", 1.0f);
    } else {
        int topIdx = -1;
        int topMax = -1;
        
        for (uint i = 0; i < iRoomSize; i++) {
            if (aiVoters[i] > topMax) {
                topMax = aiVoters[i];
                topIdx = i;
            }
        }
        
        int iMinutes = g_iTimeLeftToVote / 60;
        int iSeconds = g_iTimeLeftToVote % 60;
        
        g_PlayerFuncs.HudMessageAll(hudParams, "Voting: " + iMinutes + ":" + (iSeconds < 10 ? "0" : "") + iSeconds + "\n\nMap: " + g_rgszFirstMap[topIdx]);
        
        g_iTimeLeftToVote--;
        if (g_iTimeLeftToVote < 0) {
            g_SoundSystem.EmitSoundDyn(g_EntityFuncs.Instance(0).edict() /* worldspawn */, CHAN_STATIC, "buttons/bell1.wav", 1.0f, ATTN_NONE, 0, 100);
            
            g_nCurrentlySelectedMap = topIdx;
            
            if (g_rgszBootCampMap[topIdx].Length() < 1) {
                if (g_rgszSecondMap[topIdx].Length() < 1) {
                    g_Scheduler.SetTimeout("ChangeToFirstSpecifiedMap", 2.0f);
                } else {
                    g_Scheduler.SetTimeout("StartSkipIntroVote", 2.0f);
                }
            } else {
                g_Scheduler.SetTimeout("StartBootCampVote", 2.0f);
            }
            
        } else {
            if (g_iTimeLeftToVote < 10)
                g_SoundSystem.EmitSoundDyn(g_EntityFuncs.Instance(0).edict() /* worldspawn */, CHAN_STATIC, "buttons/blip1.wav", 1.0f, ATTN_NONE, 0, 100);
            g_Scheduler.SetTimeout("CheckersThink", 1.0f);
        }
    }
}

void MapInit() {
    g_SoundSystem.PrecacheSound("buttons/blip1.wav");
    g_SoundSystem.PrecacheSound("buttons/bell1.wav");
    
    g_rgszCampaignSprites.resize(0);
    g_rgszBootCampMap.resize(0);
    g_rgszFirstMap.resize(0);
    g_rgszSecondMap.resize(0);
    
    g_rgnScaryIndexes.resize(0);
    
    if (g_bHalloweenMode)
        g_rgnScaryIndexes.insertLast(1337);
    
    ParseCampaignListFile();
}

void MapActivate() {
    g_model_ascii.resize(95);
    
    for (int idx = 0; idx < g_Engine.maxEntities; ++idx) {
        CBaseEntity@ pEntity = g_EntityFuncs.Instance(idx);
        
        if (pEntity !is null) {
            string szTargetName = pEntity.pev.targetname;
            
            if (szTargetName == "wall_vote") {
                g_lpszModelWallVote = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "wall_default") {
                g_lpszModelWallDefault = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "floor_vote") {
                g_lpszModelFloorVote = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "floor_default") {
                g_lpszModelFloorDefault = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling") {
                g_lpszModelTheyHungerFloorWithCeiling1 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling_2") {
                g_lpszModelTheyHungerFloorWithCeiling2 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling_3") {
                g_lpszModelTheyHungerFloorWithCeiling3 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor") {
                g_lpszModelTheyHungerFloor1 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_2") {
                g_lpszModelTheyHungerFloor2 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_3") {
                g_lpszModelTheyHungerFloor3 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling_vote") {
                g_lpszModelFloorWithCeilingTheyHungerVote = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_vote") {
                g_lpszModelFloorTheyHungerVote = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_wall_curved_1") {
                g_rgszModelsTheyHungerWallsCurved.insertLast(pEntity.pev.model);
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_wall_curved_2") {
                g_rgszModelsTheyHungerWallsCurved.insertLast(pEntity.pev.model);
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_wall_curved_3") {
                g_rgszModelsTheyHungerWallsCurved.insertLast(pEntity.pev.model);
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_wall_curved_4") {
                g_rgszModelsTheyHungerWallsCurved.insertLast(pEntity.pev.model);
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_wall_vote") {
                g_lpszModelWallTheyHungerVote = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_end") {
                g_lpszModelEnclosingWallTheyHunger = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_wall_default") {
                g_lpszModelDefaultWallTheyHunger = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_tree") {
                g_hTheyHungerTree = EHandle(pEntity);
            } else if (szTargetName == "th_wall_ceiling") {
                g_lpszModelTheyHungerCeiling = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "xmas_snow") {
                g_lpszModelTheyHungerXMasSnow = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling_xmas") {
                g_lpszModelTheyHungerFloorWithCeilingAndSnow1 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling_2_xmas") {
                g_lpszModelTheyHungerFloorWithCeilingAndSnow2 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling_3_xmas") {
                g_lpszModelTheyHungerFloorWithCeilingAndSnow3 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_xmas") {
                g_lpszModelTheyHungerFloorAndSnow1 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_2_xmas") {
                g_lpszModelTheyHungerFloorAndSnow2 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_3_xmas") {
                g_lpszModelTheyHungerFloorAndSnow3 = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_ceiling_vote_xmas") {
                g_lpszModelFloorWithCeilingAndSnowTheyHungerVote = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName == "th_floor_vote_xmas") {
                g_lpszModelFloorAndSnowTheyHungerVote = pEntity.pev.model;
                g_EntityFuncs.Remove(pEntity);
            } else if (szTargetName.Find("ascii_") == 0) {
                if (szTargetName == "ascii_err") {
                    g_model_ascii_error = pEntity.pev.model;
                } else {
                    int ascii_number = atoi(szTargetName.SubString(6));
                    g_model_ascii[ascii_number - 32] = pEntity.pev.model;
                }
                g_EntityFuncs.Remove(pEntity);
            }
        }
    }
    
    int iRoomSize = g_rgszFirstMap.size();
    if (iRoomSize > 63) iRoomSize = 63;
    
    if (g_rgnScaryIndexes.length() > 0 && IsIndexScary(-1)) {
        AddDefaultWallTheyHunger(-128 - iRoomSize * 128, 768);
        AddDefaultWallTheyHunger(-128 - iRoomSize * 128, 512);
        AddDefaultWallTheyHunger(-128 - iRoomSize * 128, 256);
        AddDefaultWallTheyHunger(-128 - iRoomSize * 128, 0);
    } else {
        AddWallDefault(-128 - iRoomSize * 128, 768);
        AddWallDefault(-128 - iRoomSize * 128, 512);
        AddWallDefault(-128 - iRoomSize * 128, 256);
        AddWallDefault(-128 - iRoomSize * 128, 0);
    }
    
    if (g_rgnScaryIndexes.length() > 0) {
        AddWallTheyHunger(128 + iRoomSize * 128, 768);
        AddWallTheyHunger(128 + iRoomSize * 128, 512);
        AddWallTheyHunger(128 + iRoomSize * 128, 256);
        AddWallTheyHunger(128 + iRoomSize * 128, 0);
    } else {
        AddWallDefault(128 + iRoomSize * 128, 768);
        AddWallDefault(128 + iRoomSize * 128, 512);
        AddWallDefault(128 + iRoomSize * 128, 256);
        AddWallDefault(128 + iRoomSize * 128, 0);
    }
    
    bool bHasPlacedCeiling = false;
    
    for(int i = 0; i < iRoomSize; i++) {
        if (!IsIndexScary(i - 1)) {
            AddWallVote(i * 256 - iRoomSize * 128 + 128, 1024);
        } else {
            AddWallVoteTheyHunger(i * 256 - iRoomSize * 128 + 128, 1024);
        }
        if (g_rgszCampaignSprites[i].Length() > 0) {
            dictionary dictKeyValues = {
                {"vp_type", "4"},
                {"scale", "0.5"},
                {"framerate", "10"}
            };
            
            CBaseEntity@ pEntity = g_EntityFuncs.CreateEntity("env_sprite", dictKeyValues);
            pEntity.pev.angles = Vector(0, 90, 0);
            pEntity.pev.renderamt = 255;
            pEntity.pev.rendercolor = Vector(200, 200, 200);
            pEntity.pev.rendermode = kRenderTransAlpha;
            pEntity.pev.renderfx = kRenderFxNone;
            g_EntityFuncs.SetModel(pEntity, g_rgszCampaignSprites[i]);
            g_EntityFuncs.SetOrigin(pEntity, Vector(i * 256 - iRoomSize * 128 + 128, 895, 2120));
        }
        if (!IsIndexScary(i - 1)) {
            AddFloorVote(i * 256 - iRoomSize * 128 + 128, 768);
            AddFloorDefault(i * 256 - iRoomSize * 128 + 128, 512);
            AddFloorDefault(i * 256 - iRoomSize * 128 + 128, 256);
            AddFloorDefault(i * 256 - iRoomSize * 128 + 128, 0);
            AddWallDefault(i * 256 - iRoomSize * 128 + 128, -256);
        } else {
            AddSnow(i * 256 - iRoomSize * 128 + 128, 0);
            AddSnow(i * 256 - iRoomSize * 128 + 128, 256);
            AddSnow(i * 256 - iRoomSize * 128 + 128, 512);
            AddSnow(i * 256 - iRoomSize * 128 + 128, 768);
            if (!bHasPlacedCeiling) {
                AddEnclosingCeilingTheyHungerWindowWall(i * 256 - iRoomSize * 128 + 128, 1536);
                AddFloorVoteTheyHunger(i * 256 - iRoomSize * 128 + 128, 768, false);
                AddFloorWithCeilingTheyHungerFirst(i * 256 - iRoomSize * 128 + 128, 0); //1
                AddFloorWithCeilingTheyHungerSecond(i * 256 - iRoomSize * 128 + 128, 256); //2
                AddFloorWithCeilingTheyHungerThird(i * 256 - iRoomSize * 128 + 128, 512); //3
                AddCeilingTheyHunger(i * 256 - iRoomSize * 128 + 128, 768);
                AddCeilingTheyHunger(i * 256 - iRoomSize * 128 + 128, 1024);
                AddCeilingTheyHunger(i * 256 - iRoomSize * 128 + 128, 1280);
                bHasPlacedCeiling = true;
            } else {
                AddFloorVoteTheyHunger(i * 256 - iRoomSize * 128 + 128, 768, false);
                AddFloorTheyHungerFirst(i * 256 - iRoomSize * 128 + 128, 0); //1
                AddFloorTheyHungerSecond(i * 256 - iRoomSize * 128 + 128, 256); //2
                AddFloorTheyHungerThird(i * 256 - iRoomSize * 128 + 128, 512); //3
            }
            AddDefaultWallTheyHunger(i * 256 - iRoomSize * 128 + 128, -256);
        }
        
        if (g_hTheyHungerTree.IsValid()) {
            CBaseEntity@ lpTree = g_hTheyHungerTree.GetEntity();
            if (g_rgnScaryIndexes.length() > 0) {
                if (i == iRoomSize - 1) {
                    AddFloorTheyHungerThird(i * 256 - iRoomSize * 128 + 512, 1280);
                    g_EntityFuncs.SetOrigin(lpTree, Vector(i * 256 - iRoomSize * 128 + 512, 1280, 2020));
                    lpTree.pev.scale = 1.5f;
                }
            } else {
                g_EntityFuncs.Remove(lpTree);
            }
        }
    }
    
    g_Scheduler.SetTimeout("CheckersThink", 1.0f);
}

void MapStart() {
    CBaseEntity@ lpWall;
    while ((@lpWall = g_EntityFuncs.FindEntityByClassname(lpWall, "func_wall")) !is null)
        lpWall.pev.effects |= EF_NODECALS;
}