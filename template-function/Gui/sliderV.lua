--sliderV
-- Слайдер вертикаль



    
    
    --[[
    block = Отчертить рамку для ориентации, а так всегда 0
    CtrlSpeed = Замедление при ctrl. чем больше значения - тем больше замедление, обычно 5
    x,y,w,h = размер рамки (фейдера)
    w_s  = ширина ползунка
    y_gro,h_gro = ширина колеи
    valSlider = значение фейдера
    --]]
    
    
    
    
    
    
    -----------------------------------------
    function gfx_slider(x,y,w,h)
        -- Рисуем ручку слайдера (пример ниже)
    end
    
    function grooveSlider(x,y,w,h)
        -- Рисуем ползунок слайдера
    end
    
    --local slV;
    function sliderV(block,CtrlSpeed,x,y,w,h,w_s,x_gro,w_gro,valSlider);
        -- valSlider = 0-1
        ------
        slV=slV or {};
        ------
        if block == true or block == 1 then;
            gfx.rect(x, y, w, h,0)--block
        end;
        -----
        grooveSlider(x_gro,y,w_gro,h,(valSlider or 0));
        ----- 
        local Mouse =
        gfx.mouse_x>=x and gfx.mouse_x<(x+w)and
        gfx.mouse_y>=y and gfx.mouse_y<(y+h);
        -----
        if slV.mouseCtrl and gfx.mouse_cap&5 ~= 5 then slV.resistor = nil  end;
        if slV.mouseCtrl and gfx.mouse_cap&5 == 5 then slV.resistor = true end;
        ----
        if Mouse and gfx.mouse_cap == 0 then slV.resistor = true end;
        ---- 
        if gfx.mouse_cap&1 == 1 and gfx.mouse_cap&5 ~= 5 and slV.resistor then;
           
            local slider = gfx.mouse_y;
            if slider+(w_s/2) >= h+y then slider = h+y-(w_s/2) end;
            if slider-(w_s/2) <=   y then slider =   y+(w_s/2) end;
            gfx_slider(x, slider-(w_s/2), w, w_s);
            slV.drawnSlider = true;
            valSlider = (gfx.mouse_y - y) / h;
            if valSlider > 1 then valSlider = 1 elseif valSlider < 0 then valSlider = 0 end;
        elseif gfx.mouse_cap&1 == 1 and gfx.mouse_cap&5 == 5 and slV.resistor then;
            if not slV.mouseCtrl then slV.mouseCtrl = (valSlider * h)+y end;
            local slider = slV.mouseCtrl -((slV.mouseCtrl - gfx.mouse_y)/(1.5*(CtrlSpeed or 1)));           
            if slider+(w_s/2) >= h+y then slider = h+y-(w_s/2) end;
            if slider-(w_s/2) <=   y then slider =   y+(w_s/2) end;
            gfx_slider(x, slider-(w_s/2), w, w_s);
            slV.drawnSlider = true;
            valSlider = (slider - y) / h;
            if valSlider > 1 then valSlider = 1 elseif valSlider < 0 then valSlider = 0 end;
        elseif gfx.mouse_cap == 0 and not Mouse then;
            slV.resistor = false;
        end;
        ---
        if gfx.mouse_cap == 0 --[[or gfx.mouse_cap&5 ~= 5 and not Mouse]] then;
           slV.mouseCtrl = false;
        end;
        ----
        if not slV.drawnSlider then;
            valSlider = (valSlider or 0);
            local slider = (valSlider * h)+y;
            if slider+(w_s/2) >= h+y then slider = h+y-(w_s/2) end;
            if slider-(w_s/2) <=   y then slider =   y+(w_s/2) end;
            gfx_slider(x, slider-(w_s/2), w, w_s);
        end;
        slV.drawnSlider = false;
        return tonumber(string.format("%.3f", valSlider)); --valSlider;
    end;
    -----------------------------------------------------------------
    
    
    --[[
    local function loop();
    
        RR = sliderV(0,5,  50, 15, gfx.w/2,30,25 ,27.5,5 ,RR or 0.5);
        --RR = sliderV(0,5,  30, 15, 30,gfx.h/2,  25   ,32,26 ,RR or 0.5); --Пример 4
    end
    --]]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        --[[Пример 4
    -------------------------------------
    function grooveSlider(x,y,w,h,val);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.gradrect(x,y,w,h,1,1,1,1,0,0,0,0, -1/h,-1/h,-1/h,0)
        gfx.r,gfx.g,gfx.b = .7,.7,.7;
        gfx.rect(x, y, w, h,0);
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    
    
    
    local function gfx_slider(x,y,w,h);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        --[--
        gfx.r,gfx.g,gfx.b = .4,.4,.4
        gfx.rect(x, y, w, h,1)
        gfx.r,gfx.g,gfx.b = .7,.7,.7; 
        gfx.rect(x, y, w, h,0)
        
        gfx.rect(x, y+(h/2-.5), 5, 1,1)
        gfx.rect(x+w-5, y+(h/2-.5), 5, 1,1)
         
        gfx.rect(x+5,y+(h/4),w-10,1,1)
        gfx.rect(x+5,y+(h/1.35),w-10,1,1)
        
        gfx.rect(x+10,y+(h/2-.5),w-20,1,1)
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    -------------------------------------
    --]]
    
    
