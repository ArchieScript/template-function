


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



      -- курсор в этих координатах л.к.мыши не нажата; вернет  0
      -- нажата в этих координатах л.к.мыши;           вернет  1
      -- отжата в этих координатах л.к.мыши;           вернет  2
      -- за приделами этих координатах;                вернет -1
      -- на каждой кнопке свой buf



    local mouse_btn_down,fake,lamp = {},{},{}
    local function LeftMouseButton(x, y, w, h,numbuf)
        if Mouse_Is_Inside(x, y, w, h) then;
            if gfx.mouse_cap&1 == 0 then fake[numbuf] = 1 end;
            if gfx.mouse_cap&1 == 0 and lamp[numbuf] ~= 0 then mouse_btn_down[numbuf] = 0 end;
            if gfx.mouse_cap&1 == 1 and fake[numbuf]==1 then mouse_btn_down[numbuf]=1 lamp[numbuf]=0; end; 
            if mouse_btn_down[numbuf] == 2 then mouse_btn_down[numbuf] = -1 end;
            if gfx.mouse_cap&1 == 0 and fake[numbuf] == 1 and mouse_btn_down[numbuf] == 1 then;
                mouse_btn_down[numbuf] = 2 lamp[numbuf] = nil;
            end;
        else 
            mouse_btn_down[numbuf] = -1 lamp[numbuf]=nil;
            if gfx.mouse_cap&1 == 1 and fake[numbuf] == 1 then mouse_btn_down[numbuf] = 1 end;
            if gfx.mouse_cap&1 == 0 then fake[numbuf] = nil end;
        end  
        return mouse_btn_down[numbuf];
    end
    --=================================



    LeftMouse = LeftMouseButton(x, y, w, h,duf)
    if LeftMouse == 0 then 
        -- курсор в этих координатах л.к.мыши не нажата (например для подсветки)
    elseif LeftMouse == 1 then
        --когда нажата л.к.мыши в этих координатах --зажечь кнопку;(или какое то действие) 
    elseif LeftMouse == 1 then
        -- когда отжата(нажата и отжата) л.к.мыши в этих координатах --выполнить действие
    end

    --======================================================================



