








    --======================================================================================
    --////////////// SCRIPT \\\\\\\\\\\\\\  SCRIPT  //////////////  SCRIPT  \\\\\\\\\\\\\\\\
    --======================================================================================




    --Mod ##########  Mod  ##########  Mod  ########  Mod  ##########  Mod  ##########  Mod  ##########  Mod  ################
    local function GetSubdirectoriesUpToLevelFive(Path);----------------------------------------------------------------------#
      local T,Enu,s,h = {Path},reaper.EnumerateSubdirectories,"\\",math.huge;--------------------------------------------------#
      for i=0,h do;f1 = Enu(Path,i);if f1 then;T[#T+1]=Path..s..f1;-------------------------------------------------------------#
        for i2=0,h do;f2=Enu(Path..s..f1,i2)if f2 then T[#T+1]=Path..s..f1..s..f2;-----------------------------------------------#
          for i3=0,h do;f3=Enu(Path..s..f1..s..f2,i3)if f3 then T[#T+1]=Path..s..f1..s..f2..s..f3;--------------------------------#
            for i4=0,h do;f4 = Enu(Path..s..f1..s..f2..s..f3,i4)if f4 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4;---------------#
              for i5=0,h do;f5=Enu(Path..s..f1..s..f2..s..f3..s..f4,i5)if f5 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4..s..f5;--#
              -----------------------------------------------------------------------------------------------------------------------#
              end;if not f5 then break end;end;--#########  ##     ##  ## ####      #####     ##       ##    #####    # #####    ##  #
            end;if not f4 then break end;end;----#########  ##     ##  ########    #######    ##       ##   ##   ##   ########   ##  #
          end;if not f3 then break end;end;------##         ##     ##  ##     ##  ##     ##   ##           ##     ##  ##     ##  ##  #
        end;if not f2 then break end;end;--------##         ##     ##  ##     ##  ##         #####     ##  ##     ##  ##     ##  ##  #
      end;if not f1 then return T end;end;-------#########  ##     ##  ##     ##  ##          ##       ##  ##     ##  ##     ##  ##  #
    end;-----------------------------------------#########  ##     ##  ##     ##  ##     ##   ##   ##  ##  ##     ##  ##     ##      #
    ---------------------------------------------##          #######   ##     ##   #######     #####   ##   ##   ##   ##     ##  ##  #
    local function GetModule(Path,file);---------##           #####    ##     ##    #####       ###    ##    #####    ##     ##  ##  #
    local FolPath,mod,Way = GetSubdirectoriesUpToLevelFive(Path);--------------------------------------------------------------------#
    FolPath[-1]=Path..'/Scripts/Archie-ReaScripts/Functions';FolPath[0]=select(2,reaper.get_action_context()):match("(.+)[\\]");-----#
    for i=-1,#FolPath do;for i2 = 0,math.huge do; local f = reaper.EnumerateFiles(FolPath[i],i2);------------------------------------#
    if f == file then mod=true Way=FolPath[i]break end;if not f then break end;end; if mod then return mod,Way end;end;end;----------#
    ---------------------------------------------------------------------------------------------------------------------------------#
    local found_mod,ScriptPath,Arc = GetModule(reaper.GetResourcePath():gsub('%\\','/'),"Arc_Function_lua.lua")---------------------#
    if not found_mod then reaper.ClearConsole()reaper.ShowConsoleMsg('Missing file "Arc_Function_lua",\nDownload from'..-----------#
    'repository Archie-ReaScript and put in resources of Reaper.\nОтсутствует файл "Arc_Function_lua",\nСкачайте из '..-----------#
    'репозитория Archie-ReaScript и поместите в ресурсы Reaper') return end------------------------------------------------------#
    package.path = package.path..";"..ScriptPath.."/?.lua"----------------------------------------------------------------------#
    Arc = require "Arc_Function_lua"-------------------------------------------------------------------------------------------#
    Arc.VersionArc_Function_lua("2.0.6",ScriptPath,"")------------------------------------------------------------------------#
    --=====================================================================================================================--#
    --#######################################################################################################################   
    
    -------------===================================
    
 



    --======================================================================================
    --////////////// SCRIPT \\\\\\\\\\\\\\  SCRIPT  //////////////  SCRIPT  \\\\\\\\\\\\\\\\
    --======================================================================================




    --Mod ##########  Mod  ##########  Mod  ########  Mod  ##########  Mod  ##########  Mod  ##########  Mod  ################
    local function GetSubdirectoriesUpToLevelFive(Path);----------------------------------------------------------------------#
      local T,Enu,s,h = {Path},reaper.EnumerateSubdirectories,"\\",math.huge;--------------------------------------------------#
      for i=0,h do;f1 = Enu(Path,i);if f1 then;T[#T+1]=Path..s..f1;-------------------------------------------------------------#
        for i2=0,h do;f2=Enu(Path..s..f1,i2)if f2 then T[#T+1]=Path..s..f1..s..f2;-----------------------------------------------#
          for i3=0,h do;f3=Enu(Path..s..f1..s..f2,i3)if f3 then T[#T+1]=Path..s..f1..s..f2..s..f3;--------------------------------#
            for i4=0,h do;f4 = Enu(Path..s..f1..s..f2..s..f3,i4)if f4 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4;---------------#
              for i5=0,h do;f5=Enu(Path..s..f1..s..f2..s..f3..s..f4,i5)if f5 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4..s..f5;--#
              -----------------------------------------------------------------------------------------------------------------------#
              end;if not f5 then break end;end;-- #########  ##     ##  ## ####      #####     ##       ##    #####    # #####    ## #
            end;if not f4 then break end;end;--- #########  ##     ##  ########    #######    ##       ##   ##   ##   ########   ##  #
          end;if not f3 then break end;end;---- ##         ##     ##  ##     ##  ##     ##   ##           ##     ##  ##     ##  ##   #
        end;if not f2 then break end;end;----- ##         ##     ##  ##     ##  ##         #####     ##  ##     ##  ##     ##  ##    #
      end;if not f1 then return T end;end;--- #########  ##     ##  ##     ##  ##          ##       ##  ##     ##  ##     ##  ##     #
    end;------------------------------------ #########  ##     ##  ##     ##  ##     ##   ##   ##  ##  ##     ##  ##     ##          #
    --------------------------------------- ##          #######   ##     ##   #######     #####   ##   ##   ##   ##     ##  ##       #
    local function GetModule(Path,file);-- ##           #####    ##     ##    #####       ###    ##    #####    ##     ##  ##        #
    local FolPath,mod,Way = GetSubdirectoriesUpToLevelFive(Path);--------------------------------------------------------------------#
    FolPath[-1]=Path..'/Scripts/Archie-ReaScripts/Functions';FolPath[0]=select(2,reaper.get_action_context()):match("(.+)[\\]");-----#
    for i=-1,#FolPath do;for i2 = 0,math.huge do; local f = reaper.EnumerateFiles(FolPath[i],i2);------------------------------------#
    if f == file then mod=true Way=FolPath[i]break end;if not f then break end;end; if mod then return mod,Way end;end;end;----------#
    ---------------------------------------------------------------------------------------------------------------------------------#
    local found_mod,ScriptPath,Arc = GetModule(reaper.GetResourcePath():gsub('%\\','/'),"Arc_Function_lua.lua")---------------------#
    if not found_mod then reaper.ClearConsole()reaper.ShowConsoleMsg('Missing file "Arc_Function_lua",\nDownload from'..-----------#
    'repository Archie-ReaScript and put in resources of Reaper.\nОтсутствует файл "Arc_Function_lua",\nСкачайте из '..-----------#
    'репозитория Archie-ReaScript и поместите в ресурсы Reaper') return end------------------------------------------------------#
    package.path = package.path..";"..ScriptPath.."/?.lua"----------------------------------------------------------------------#
    Arc = require "Arc_Function_lua"-------------------------------------------------------------------------------------------#
    Arc.VersionArc_Function_lua("2.0.6",ScriptPath,"")------------------------------------------------------------------------#
    --=====================================================================================================================--#
    --####################################################################################################################### 
    
    -------------===========================

    --======================================================================================
    --////////////// SCRIPT \\\\\\\\\\\\\\  SCRIPT  //////////////  SCRIPT  \\\\\\\\\\\\\\\\
    --======================================================================================




    --Mod ##########  Mod  ##########  Mod  ########  Mod  ##########  Mod  ##########  Mod  ##########  Mod  ################
    local function GetSubdirectoriesUpToLevelFive(Path);----------------------------------------------------------------------#
      local T,Enu,s,h = {Path},reaper.EnumerateSubdirectories,"\\",math.huge;--------------------------------------------------#
      for i=0,h do;f1 = Enu(Path,i);if f1 then;T[#T+1]=Path..s..f1;-------------------------------------------------------------#
        for i2=0,h do;f2=Enu(Path..s..f1,i2)if f2 then T[#T+1]=Path..s..f1..s..f2;-----------------------------------------------#
          for i3=0,h do;f3=Enu(Path..s..f1..s..f2,i3)if f3 then T[#T+1]=Path..s..f1..s..f2..s..f3;--------------------------------#
            for i4=0,h do;f4 = Enu(Path..s..f1..s..f2..s..f3,i4)if f4 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4;---------------#
              for i5=0,h do;f5=Enu(Path..s..f1..s..f2..s..f3..s..f4,i5)if f5 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4..s..f5;--#
              ---------------------------------------------------------#------------------------------------------------------------#
              end;if not f5 then break end;end;---- #######----#######--------#####------##-----##----##----########------##--------#
            end;if not f4 then break end;end;----- ########----########------#######-----##-----##----##----########------##--------#
          end;if not f3 then break end;end;-------##-----##----##-----##----##-----##----##-----##----------##------------##--------#
        end;if not f2 then break end;end;---------##-----##----##-----##----##-----------#########----##----########------##--------#
      end;if not f1 then return T end;end;--------#########----########-----##-----------#########----##----########------##--------#
    end;------------------------------------------#########----#######------##-----##----##-----##----##----##----------------------#
    ----------------------------------------------##-----##----##----##------#######-----##-----##----##----########------##--------#
    local function GetModule(Path,file);----------##-----##----##-----##------#####------##-----##----##----########------##--------#
    local FolPath,mod,Way = GetSubdirectoriesUpToLevelFive(Path);-------------------------------------------------------------------#
    FolPath[-1]=Path..'/Scripts/Archie-ReaScripts/Functions';FolPath[0]=select(2,reaper.get_action_context()):match("(.+)[\\]");----#
    for i=-1,#FolPath do;for i2 = 0,math.huge do; local f = reaper.EnumerateFiles(FolPath[i],i2);-----------------------------------#
    if f == file then mod=true Way=FolPath[i]break end;if not f then break end;end; if mod then return mod,Way end;end;end;---------#
    --------------------------------------------------------------------------------------------------------------------------------#
    local found_mod,ScriptPath,Arc = GetModule(reaper.GetResourcePath():gsub('%\\','/'),"Arc_Function_lua.lua")---------------------#
    if not found_mod then reaper.ClearConsole()reaper.ShowConsoleMsg('Missing file "Arc_Function_lua",\nDownload from'..-----------#
    'repository Archie-ReaScript and put in resources of Reaper.\nОтсутствует файл "Arc_Function_lua",\nСкачайте из '..-----------#
    'репозитория Archie-ReaScript и поместите в ресурсы Reaper') return end------------------------------------------------------#
    package.path = package.path..";"..ScriptPath.."/?.lua"----------------------------------------------------------------------#
    Arc = require "Arc_Function_lua"-------------------------------------------------------------------------------------------#
    Arc.VersionArc_Function_lua("2.0.5",ScriptPath,"")------------------------------------------------------------------------#
    --=====================================================================================================================--#
    --#######################################################################################################################
