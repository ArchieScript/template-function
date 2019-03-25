



    Path = "C:\\Users\\User\\Desktop\\Reaper"
    dirname = "NewFolder"
    
    --NewFolder--
    os.execute('mkdir "'..Path..'\\'.. dirname..'"') -- windows
    
    --NewFile--
    newFile = io.open( Path.."/"..dirname.."\\File.txt", "w+" ) -- windows
    newFile:write( "fghgljklhjg" )
    newFile:close()







------------------------
  -- mac ???

-- os.execute('mkdir -p ~/Documents/"Your folder"')

--------------------------


--https://qasseta.ru/q/116798/не-удается-создать-папку-в-lua-на-всех-платформах
