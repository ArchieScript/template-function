


---------------//////////////////////////        GUI     /////////////////////////////////------------------------



-----------------------------------------------------------------------------
local function No_Undo()end; local function no_undo()reaper.defer(No_Undo)end
-----------------------------------------------------------------------------
 
 
--==================================================================== 
 
      
      
    
    local function msg(param);reaper.ShowConsoleMsg(param.."\n")end   -- msg('test') 
    
    
    
        --xOut , yOut =50,200--  reaper.GetMousePosition()  xOut , yOut = xOut-250, yOut-150 
        xOut , yOut = reaper.GetMousePosition()  xOut , yOut = xOut-230, yOut-125                           
        header = [=[Toggle: zoom selected items open-close inline]=]
        gfx.clear = 4210752
        gfx.init(header,350 , 105,0,xOut, yOut  )
        --- 
      
    function main(numb) 
      
        gfx.setfont(1,"Verdana",15,117) --установить Шрифты
        gfx.set(0,0.75,0.75,1) -- r,g,b,a, устанавливаем цвет, которым будем рисовать info
        gfx.x, gfx.y = 25, 18 -- уст. gfx.x, gfx.y, строки рисуются отталкиваясь от этих координат!
        gfx.drawstr([=[NO SELECTED MEDIA ITEM in TIME SELECTION !]=])
        gfx.setfont(1,"Verdana",15,105) --установить Шрифты 
        gfx.x, gfx.y = 100, 40
        gfx.drawstr([=[Select an item in time selection ]=])       
        ---  
     
        local button = numb -- = 0       
      
        gfx.set(0.4,0.4,0.4,1) -- r,g,b,a, устанавливаем цвет, которым будем рисовать info              
        gfx.roundrect(115, 65, 100, 30, 4)--Рисует прямоугольник с закругленными углами. 
        
        if button == 1 then              
            gfx.gradrect(117,67,97,27, 0.2,0.2,0.2,1)--Заполняет прямоугольник градиента указанным цветом и альфой(x,y,w,h, r,g,b,a) 
        elseif button == 0 then    
            gfx.gradrect(117,67,97,27, 0.3,0.3,0.3,1)--Заполняет прямоугольник градиента указанным цветом и альфой(x,y,w,h, r,g,b,a) 
        end   
        
      
        gfx.line(213,93,117,67 )
        gfx.line(213,67,117,93 )
        gfx.roundrect(119, 69, 92, 22, 4)----Рисует прямоугольник с закругленными углами.
        
        if button == 1 then 
            gfx.gradrect(119,69,92,22, 0.5,0.5,0.5,1)--Заполняет прямоугольник градиента указанным цветом и альфой(x,y,w,h, r,g,b,a) 
        elseif button == 0 then
            gfx.gradrect(119,69,92,22, 0.4,0.4,0.4,1)--Заполняет прямоугольник градиента указанным цветом и альфой(x,y,w,h, r,g,b,a) 
        end
        ---
       
        gfx.x, gfx.y = 156, 71 -- уст. gfx.x, gfx.y, строки рисуются отталкиваясь от этих координат! 
        x,y = gfx.x, gfx.y--уст. gfx.x, gfx.y,строки рисуются отталкиваясь от этих координат! 
        gfx.setfont(1,"Verdana",18,105) --установить Шрифты
        
        if button == 1 then 
            gfx.set(0, 0, 0, 0.3)-- r,g,b,a, устанавливаем цвет, которым будем рисовать info 
        elseif button == 0 then
            gfx.set(0, 0, 0, 0.7)-- r,g,b,a, устанавливаем цвет, которым будем рисовать info 
        end
        for i = 1, 3 do
          gfx.x, gfx.y = x + i, y-i
          gfx.drawstr("OK")
        end
        
        gfx.set(0.8,0.8,0.8,0.9) -- r,g,b,a, устанавливаем цвет, которым будем рисовать info  
        gfx.x, gfx.y = x,y
        gfx.drawstr("OK")
    
    end
    ---
    
    
    ----------------
    function Mouse_Is_Inside(x, y, w, h) --мышь находится внутри
        local mouse_x, mouse_y = gfx.mouse_x, gfx.mouse_y
        local inside = 
        mouse_x >= x and mouse_x < (x + w) and 
        mouse_y >= y and mouse_y < (y + h) 
        return inside
    end
    ----------------- 
    
    
    
    function loop()
    
        -- If the left button is down
        if gfx.mouse_cap&1 == 1  then
            -- If the cursor is inside the rectangle AND the button wasn't down before
            if Mouse_Is_Inside(117,70,98,23) and not mouse_btn_down then
                main(1)
                mouse_btn_down = true
                state = 1
            end
        -- If the left button is up
        else
            main(0)
            mouse_btn_down = false
        end
        
        if gfx.mouse_cap&1 == 0 and  Mouse_Is_Inside(117,70,98,23) and state == 1 then gfx.quit() end
        if not Mouse_Is_Inside(117,70,98,23) then state = 0 end
        if gfx.getchar() >= 0 then reaper.defer(loop)else reaper.atexit(gfx.quit) end 
        gfx.update()
        
    end
    
        loop()
     
    
    
    


--==============================================///////////////////////================================================


 



---*****************************************************************************************************************************

---GUI

 gfx.clear = 4210752
 gfx.init("bla",250 , 50,0,80, 100 )
 gfx.setfont(1,"Verdana",15)
 
  gfx.set(0,0.75,0.75,1) -- r,g,b,a, устанавливаем цвет, которым будем рисовать info
  gfx.x, gfx.y = 25, 18 -- уст. gfx.x, gfx.y, строки рисуются отталкиваясь от этих координат!
  gfx.drawstr("[view] Peaks 4.1 db  (1/6)" )
 --[
 r=0
 for i = 1,1000000 do
 r=r+1
 gfx.update()
 end
 --[
 if r == 1000000 then
 gfx.quit()
 end
 
 --gfx.quit()   

    
  --*****************************************************************************************************
  
    
    
    
    
