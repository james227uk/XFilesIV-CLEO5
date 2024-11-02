 8 �  � �	MAIN    �d )root:\modloader\a x-files iv\xfilesiv.log��E^�/E��E^�/E�-A� �  � S  �E^�/E�-A �  � �� { PLAYER_FACEHEAD{ 
JEANSDENIMJEANS{ SNEAKERBINCBLKSNEAKER{ VESTVEST  l�x�D����
�A  	C m���D�o���(hA  �B *  zD)� ')� ')� ')� '*E  zD*F  zD*G  zD*H  zD*I  zD*J  zD*K  zD*L  zD*M  zD*N  zD*O  zD)� _ �	 ���  H
   j �!)root:\modloader\a x-files iv\xfilesiv.log,[Main] [INFO] Launching mission 'initial'...  8 � M ����   �����O c���  8 � �� w����DBGCAML  �  �
[M ���&	   �  9    M ����
���   X����    �  M ���	   �
  G  �  9  M �����Q  ����  �  M �����
  �	initial !)root:\modloader\a x-files iv\xfilesiv.log [INFO] Loaded mission 'initial'. _�Er),Ek�A            `M"E'%,EZ�A�
����� � �[�E@�-E�-A    �
YM ��� ��N VAR    flagMissionInitialCompleted �  playerGroup �  TIME_HOURS �  TIME_MINS �  FLAG   SRC /  //========================================================================================================================================================================================================
//------------------------------------------------------------------------------------------- GTA X-Files IV (2024) --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------- By james227uk -------------------------------------------------------------------------------------------
//========================================================================================================================================================================================================
//                                                                                Developed using Sanny Builder 4 and CLEO5 Beta.
//========================================================================================================================================================================================================


//========================================================================================================================================================================================================
//    1. SCM Header 
//    Core SCM stats such as mission counts, and initial variable declarations.
//========================================================================================================================================================================================================

// --- Primary header
DEFINE MISSIONS 1
DEFINE MISSION 0 AT @Mission_Initial

DEFINE EXTERNAL_SCRIPTS 1 // Use -1 in order not to compile AAA script
DEFINE SCRIPT DBGCAMH AT @External_CameraHelper

DEFINE UNKNOWN_EMPTY_SEGMENT 0
DEFINE UNKNOWN_THREADS_MEMORY 0

// --- Import extensions & libraries
{$USE CLEO}
{$USE CLEO+}
{$USE NewOpcodes}

// --- Initial variable declarations
var 
    $player1: Player         // gta3sc/SBL analogue of PLAYER_CHAR
    $scplayer: Char          // gta3sc/SBL analogue of PLAYER_ACTOR
    $playerGroup: Group
    $mission_trigger_wait_time: Int = 250
    $flagMissionInitialCompleted: Int = False
end
const
    logPath = "root:\modloader\a X-Files IV\XFilesIV.log"
end

// External Script Name Mappings
const
    externalCameraHelper = 0
end

script_name 'MAIN'
declare_mission_flag {Name:} $ONMISSION
Fs.DeleteFile(logPath)



//========================================================================================================================================================================================================
//    2. Initialise World
//    Initialise the world and set initial properties such as weather.
//========================================================================================================================================================================================================
Streaming.RequestCollision({X:}2544.1604, {Y:}2810.7729)
Streaming.LoadScene({X:}2544.1604, {Y:}2810.7729, {Z:}10.8203)
Streaming.SetAreaVisible({InteriorID:}0)
Clock.SetTimeOfDay({Hour:}8, {Minutes:}0)
Weather.ForceNow({Weather ID:}0)



//========================================================================================================================================================================================================
//    3. Initialise Player
//    Create player and set initial stats.
//======================================================================================================================================================================================================== 

// --- Create player
Player.Create({Index:}0, {X:}2544.1604, {Y:}2810.7729, {Z:}10.8203, {Player:} $player1)
Player.GetChar({Player:} $player1, {Player Char:} $scplayer)
Player.GetGroup({Player:} $player1, {Player Group:} $playerGroup)
Player.SetControl({Player:} $player1, {State:} True)

// --- Set player clothes
Player.GiveClothesOutsideShop({Player:} $player1, {Texture:}"PLAYER_FACE",      {Model:}"HEAD",     {Body Part:}BodyPart.Head)
Player.GiveClothesOutsideShop({Player:} $player1, {Texture:}"JEANSDENIM",       {Model:}"JEANS",    {Body Part:}BodyPart.Legs)
Player.GiveClothesOutsideShop({Player:} $player1, {Texture:}"SNEAKERBINCBLK",   {Model:}"SNEAKER",  {Body Part:}BodyPart.Shoes)
Player.GiveClothesOutsideShop({Player:} $player1, {Texture:}"VEST",             {Model:}"VEST",     {Body Part:}BodyPart.Torso)
Player.BuildModel($player1)

// --- Set respawn points
Restart.AddHospital({X:}2027.77, {Y:} -1420.52, {Z:}15.99, {Heading:}137.0, {TownID:} 0)
Restart.AddPolice({X:}1550.68, {Y:}-1675.49, {Z:}14.51, {Heading:}90.0, {TownID:} 0)

// --- Set initial stats
Stat.SetFloat(StatID.MaxHealth,                     {Value:}1000.0  )
Stat.SetInt  (StatID.DrivingSkill,                  {Value:}10000   )
Stat.SetInt  (StatID.FlyingSkill,                   {Value:}10000   )
Stat.SetInt  (StatID.BikeSkill,                     {Value:}10000   )
Stat.SetInt  (StatID.CycleSkill,                    {Value:}10000   )
Stat.SetFloat(StatID.WeapontypePistolSkill,         {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypePistolSilencedSkill, {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeDesertEagleSkill,    {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeShotgunSkill,        {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeSawnoffShotgunSkill, {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeSpas12ShotgunSkill,  {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeMicroUziSkill,       {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeMp5Skill,            {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeAk47Skill,           {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeM4Skill,             {Value:}1000.0  )
Stat.SetFloat(StatID.WeapontypeSniperrifleSkill,    {Value:}1000.0  )
Stat.SetInt  (StatID.CitiesPassed,                  {Value:}4       )
Player.IncreaseMaxArmor($player1,                   {Value:}5000    )
Player.AddScore        ($player1,                   {Value:}5000    )
Game.SetMaxWantedLevel (                            {Value:}6       )
Char.SetCanBeKnockedOffBike($scplayer, false)

Game.AllowPauseInWidescreen(True)
set_deatharrest_state 0



//========================================================================================================================================================================================================
//    4. Final Initialisation
//    Final initialisation steps, launch the initial 'mission', then create initial threads.
//========================================================================================================================================================================================================
wait 0
Camera.DoFade({Duration:}0, {Direction:}Fade.In)
Text.ClearHelp()
Debugger.LogLine({Filename:}logPath, {Timestamp:}True, {Text:}"[Main] [INFO] Launching mission 'initial'...")

// Launch the initialisation 'mission'. This contains the main menu etc.
Mission.LoadAndLaunchInternal(Mission_Initial)
while $flagMissionInitialCompleted == False
    wait 0
end
Audio.PlayMissionPassedTune(2)

// Create scripts
start_new_script @Debug_CameraHelper


//========================================================================================================================================================================================================
//    5. Main Loop
//    Keep the MAIN script in a perpetual loop to prevent shenanigans.
//========================================================================================================================================================================================================
while true
    wait $mission_trigger_wait_time
    Clock.GetTimeOfDay({Hours Var:} $TIME_HOURS, {Minutes Var:} $TIME_MINS)
end


//========================================================================================================================================================================================================
//    6. Universal Scripts
//    Scripts that run in both Storymode and Freemode.
//========================================================================================================================================================================================================

:Debug_CameraHelper
script_name "DBGCAML"

while true
    wait 0
    if Pad.TestCheat("[")
    then
        StreamedScript.GetNumberOfInstances(externalCameraHelper, 0@)
        if 0@ == 0
        then
            func_runExternalScript(externalCameraHelper)
        end
    end
end

//========================================================================================================================================================================================================
//    7. Storymode Scripts
//    Scripts that run exclusively in Storymode.
//========================================================================================================================================================================================================

 

//========================================================================================================================================================================================================
//    8. Main Loop
//    Scripts that run exclusively in Freemode.
//========================================================================================================================================================================================================



//========================================================================================================================================================================================================
//    9. Functions
//    Custom functions called extensively to reduce code bloat.
//========================================================================================================================================================================================================

function func_runExternalScript(targetScript: int)
    StreamedScript.Stream(targetScript)
    repeat
        wait 0
    until StreamedScript.HasLoaded(targetScript)
    StreamedScript.StartNew(targetScript)
end



function func_loadModel(modelID: int, forceLoad: int)
    Streaming.RequestModel(modelID)
    if
        forceLoad == 1
    then
        Streaming.LoadAllModelsNow()
        return
    else
        repeat
            wait 0
        until Streaming.IsModelAvailable(modelID)
    end
end



//========================================================================================================================================================================================================
//    10. Missions
//    All missions go here. They are only loaded into memory when called.
//========================================================================================================================================================================================================

:Mission_Initial
{$INCLUDE_ONCE main\missions\Mission-Initial.txt}

//========================================================================================================================================================================================================
//    11. External Scripts
//    All external scripts go here. They are only loaded into memory when called.
//========================================================================================================================================================================================================

:External_CameraHelper
{$INCLUDE_ONCE main\externals\External-CameraHelper.txt}  __SBFTR 