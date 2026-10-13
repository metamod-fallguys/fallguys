#pragma once

#include <signatures_template.h>

// XXXX_GameSymbol is the symbolName of XXXX in the GoldSrc_VibeSignatures
// gamedata (scripts/manifests/fallguys.json), resolved by FILL_FROM_GAMEDATA /
// VAR_FROM_GAMEDATA. C++ signatures are spelled differently per platform.

#ifdef _WIN32

#    define CPlayerMove_PlayStepSound_GameSymbol "CPlayerMove::PlayStepSound(int, float, bool)"

#    define CLIENT_DLL_NAME "client.dll"

#    define CLIENT_DLL_PATH "cl_dlls\\client.dll"

#    define FMOD_DLL_NAME "fmodex.dll"

#    define FMOD_DLL_PATH "%s\\fmodex.dll"

#else

#    define CPlayerMove_PlayStepSound_GameSymbol "_ZN11CPlayerMove13PlayStepSoundEifb"

#    define CLIENT_DLL_NAME "client.so"

#    define CLIENT_DLL_PATH "cl_dlls/client.so"

#    define FMOD_DLL_NAME "fmodex.so"

#    define FMOD_DLL_PATH "%s/cl_dlls/libfmodex.so"

#endif

#define PM_PlaySoundFX_SERVER_GameSymbol   "PM_PlaySoundFX_SERVER"
#define RegisterSCScriptColor24_GameSymbol "RegisterSCScriptColor24"

#define build_number_GameSymbol             "build_number"
#define SV_Physics_GameSymbol               "SV_Physics"
#define SV_PushEntity_GameSymbol            "SV_PushEntity"
#define SV_PushMove_GameSymbol              "SV_PushMove"
#define SV_PushRotate_GameSymbol            "SV_PushRotate"
#define SV_WriteMovevarsToClient_GameSymbol "SV_WriteMovevarsToClient"

// Build 10152+ publishes the passedict variant under the same symbolName.
#define SV_SingleClipMoveToEntity_GameSymbol       "SV_SingleClipMoveToEntity"
#define SV_SingleClipMoveToEntity_10152_GameSymbol "SV_SingleClipMoveToEntity"

// Globals resolve to the address of the engine variable itself.
#define sv_models_GameSymbol      "sv_models"
#define host_frametime_GameSymbol "host_frametime"
#define pmovevars_GameSymbol      "movevars"
#define sv_areanodes_GameSymbol   "sv_areanodes"
#define pg_groupop_GameSymbol     "g_groupop"
#define pg_groupmask_GameSymbol   "g_groupmask"
