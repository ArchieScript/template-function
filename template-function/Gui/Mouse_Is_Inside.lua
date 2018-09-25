


 -- координаты мыши для кнопки
 
      x - от левого края до кнопки
      y - от верха до кнопки
      w - от левого края кнопки до правого края кнопки
      h - от верхнего края кнопки до нижнего края кнопки


    local function Mouse_Is_Inside(x, y, w, h) --мышь находится внутри
        local mouse_x, mouse_y = gfx.mouse_x, gfx.mouse_y
        local inside =
        mouse_x >= x and mouse_x < (x + w) and
        mouse_y >= y and mouse_y < (y + h)
        return inside
    end
-----------



  


----=================================================================
      
   -- что бы действие срабатывало при отжатии кнопки

   -- ТРЕБУЕСЯ Mouse_Is_Inside(x, y, w, h)


      -- нажата л.к.мыши в этих координатах вернет 0
      -- отжата л.к.мыши в этих координатах вернет 1
      -- за приделами этих координатах вернет -1
 


 
local function LeftMouseButton(x, y, w, h)
    if Mouse_Is_Inside(x, y, w, h) then
        if gfx.mouse_cap&1 == 0 then fake = 1 end
        if gfx.mouse_cap&1 == 1 and fake == 1 then  
            mouse_btn_down = 0;   
        end
        if mouse_btn_down == 1 then mouse_btn_down = -1 end
        if gfx.mouse_cap&1 == 0 and fake == 1 and mouse_btn_down == 0 then
            mouse_btn_down = 1
        end
    else
        mouse_btn_down = -1
        if gfx.mouse_cap&1 == 1 and fake == 1 then 
            mouse_btn_down = 0;  --fake = true  
        end
        if gfx.mouse_cap&1 == 0 then fake = nil end
    end   
    return mouse_btn_down
end 





 LeftMouse = LeftMouseButton(x, y, w, h)
 if LeftMouse == 0 then 
     --когда нажата л.к.мыши в этих координатах --зажечь кнопку;(или какое то действие) 
 elseif LeftMouse == 1 then
     -- когда отжата л.к.мыши в этих координатах --выполнить действие
 end





