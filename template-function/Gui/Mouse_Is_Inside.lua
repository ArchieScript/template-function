


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



  -- что бы действие срабатывало при отжатии кнопки


        if gfx.mouse_cap&1 == 1  then  -- если левая кнопка нажата
            if Mouse_Is_Inside(18,12,89,15) and not mouse_btn_down then
               
                --function()--когда нажата л.к.мыши --зажечь кнопку  
                mouse_btn_down = true
            end
        else
            if mouse_btn_down == true and Mouse_Is_Inside(18,12,89,15) then

                --function() -- когда отжата л.к.мыши --выполнить действие
                mouse_btn_down = false
            else
                mouse_btn_down = false
            end
        end




----=================================================================
      

   -- ТРЕБУЕСЯ Mouse_Is_Inside(x, y, w, h)


      -- нажата л.к.мыши в этих координатах вернет 0
      -- отжата л.к.мыши в этих координатах вернет 1
      -- за приделами этих координатах вернет -1
 
 
 local function LeftMouseButton(x, y, w, h)
     if gfx.mouse_cap&1 == 1  then  -- если левая кнопка нажата
         if Mouse_Is_Inside(x, y, w, h) and not fake then
            mouse_btn_down = 0;fake = true  
         end
     elseif fake == true and Mouse_Is_Inside(x, y, w, h)then
             mouse_btn_down = 1;fake = false
         else
             mouse_btn_down = -1;fake = false
     end
     return mouse_btn_down
 end 


 LeftMouse = LeftMouseButton(x, y, w, h)
 if LeftMouse == 1 then 
     --когда нажата л.к.мыши в этих координатах --зажечь кнопку;(или какое то действие) 
 elseif LeftMouse == 2  then
     -- когда отжата л.к.мыши в этих координатах --выполнить действие
 end





