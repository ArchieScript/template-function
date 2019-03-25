



    Path = "C:\\Users\\User\\Desktop\\Reaper"
    dirname = "NewFolder"
    
    --NewFolder--
    os.execute('mkdir "'..Path..'\\'.. dirname..'"') -- windows
    
    --NewFile--
    newFile = io.open( Path.."/"..dirname.."\\File.txt", "w+" ) -- windows
    newFile:write( "fghgljklhjg" )
    newFile:close()
