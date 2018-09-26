




             -- Форматирует значение сетки проекта в удобочитаемую форму


--local retval, divisionIn, swingmodeIn, swingamtIn = reaper.GetSetProjectGrid( 0, 0 )
  
  
  
local function Get_Format_ProjectGrid(divisionIn)
    local grid_div
    if divisionIn < 1 then
         grid_div = (1 / divisionIn)
        if math.fmod(grid_div,3) == 0 then
            grid_div = "1/"..string.format("%.0f",grid_div/1.5).."T"
        else
            grid_div = "1/"..string.format("%.0f",grid_div) 
        end
    else    
        grid_div = tonumber(string.format("%.0f",divisionIn)) 
    end    
    return grid_div
end


Get_Format_ProjectGrid(divisionIn)
















