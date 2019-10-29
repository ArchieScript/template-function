--sliderG 
-- Слайдер горизонталь






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
        -- Рисуем ручку слайдера (Пример ниже)
    end
    
    function grooveSlider(x,y,w,h)
        -- Рисуем ползунок слайдера
    end
    
    local slV;
    function sliderG(block,CtrlSpeed,x,y,w,h,w_s,y_gro,h_gro,valSlider);
        -- valSlider = 0-1
        ------
        slV=slV or {};
        ------
        if block == true or block == 1 then;
            gfx.rect(x, y, w, h,0)--block
        end;
        -----
        grooveSlider(x,y_gro,w,h_gro,(valSlider or 0));
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
            local slider = gfx.mouse_x;
            if slider+(w_s/2) >= w+x then slider = w+x-(w_s/2) end;
            if slider-(w_s/2) <=   x then slider =   x+(w_s/2) end;
            gfx_slider(slider-(w_s/2), y, w_s, h-1);
            slV.drawnSlider = true;
            valSlider = (gfx.mouse_x - x) / w;
            if valSlider > 1 then valSlider = 1 elseif valSlider < 0 then valSlider = 0 end;
        elseif gfx.mouse_cap&1 == 1 and gfx.mouse_cap&5 == 5 and slV.resistor then;
            if not slV.mouseCtrl then slV.mouseCtrl = (valSlider * w)+x end;
            local slider = slV.mouseCtrl -((slV.mouseCtrl - gfx.mouse_x)/(1.5*(CtrlSpeed or 1)));
            if slider+(w_s/2) >= w+x then slider = w+x-(w_s/2) end;
            if slider-(w_s/2) <=   x then slider =   x+(w_s/2) end;
            gfx_slider(slider-(w_s/2), y, w_s, h-1);
            slV.drawnSlider = true;
            valSlider = (slider - x) / w;
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
            local slider = (valSlider * w)+x;
            if slider+(w_s/2) >= w+x then slider = w+x-(w_s/2) end;
            if slider-(w_s/2) <=   x then slider =   x+(w_s/2) end;
            gfx_slider(slider-(w_s/2), y, w_s, h-1);
        end;
        slV.drawnSlider = false;
        return valSlider;
    end;
    -----------------------------------------------------------------
    
    
    --[[
    local function loop();
    
        RR = sliderV(0,5,  50, 15, gfx.w/2,30,25 ,27.5,5 ,RR or 0.5);
        -- RR = sliderG(0,5,  50, 15, gfx.w/2,30,25 ,20,20 ,RR or 0.5); -- Пример 4
    end
    --]]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        --[[Пример 1
    -------------------------------------
    function grooveSlider(x,y,w,h,val);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.r,gfx.g,gfx.b = .3,.3,.3;
        gfx.rect(x, y, w, h,1) 
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    
    local function gfx_slider(x,y,w,h);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.r,gfx.g,gfx.b = .4,.4,.4
        gfx.circle(x+(w/2),y+(w/2),(w/2),1);
        
        gfx.r,gfx.g,gfx.b = .59,.58,.30
        gfx.circle(x+(w/2),y+(w/2),(w/5),0,.5);
        gfx.circle(x+(w/2),y+(w/2),(w/2),0);
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end
    -------------------------------------
    --]]
    
    
    
    --[[Пример 2
    -------------------------------------
    function grooveSlider(x,y,w,h,val);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.r,gfx.g,gfx.b = .3,.3,.3;
        gfx.rect(x, y, w, h,0);
        
        gfx.rect(x, y, w*val, h,1);
        
        
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    
    
    
    local function gfx_slider(x,y,w,h);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.r,gfx.g,gfx.b = .4,.4,.4
        gfx.circle(x+(w/2),y+(w/2),(w/2.5),1);
        
        gfx.r,gfx.g,gfx.b = .59,.58,.30
        gfx.circle(x+(w/2),y+(w/2),(w/6),0);
        gfx.circle(x+(w/2),y+(w/2),(w/2.5),0);
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    -------------------------------------
    --]]
    
    
    
    
    --[[Пример 3
    -------------------------------------
    function grooveSlider(x,y,w,h,val);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.r,gfx.g,gfx.b = .3,.3,.3;
        gfx.rect(x, y, w, h,0);
        
        gfx.rect(x, y, w*val, h,1);
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    
    
    
    local function gfx_slider(x,y,w,h);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.r,gfx.g,gfx.b = .4,.4,.4
        gfx.rect(x, y, w, h,1)
        
        gfx.r,gfx.g,gfx.b = .59,.58,.30
        gfx.rect(x+(w/2-.5), y, 1, 5,1)
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    -------------------------------------
    --]]
    
    
    
        --[[Пример 4
    -------------------------------------
    function grooveSlider(x,y,w,h,val);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.gradrect(x,y,w,h,1,1,1,1, -1/w,-1/w,-1/w,0)
        gfx.r,gfx.g,gfx.b = .7,.7,.7;                      
        gfx.rect(x, y, w, h,0);
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    
    
    
    local function gfx_slider(x,y,w,h);
        gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        ----
        gfx.r,gfx.g,gfx.b = .4,.4,.4
        gfx.rect(x, y, w, h,1)
        gfx.r,gfx.g,gfx.b = .7,.7,.7; 
        gfx.rect(x, y, w, h,0)
        
        gfx.rect(x+(w/2-.5), y, 1, 5,1)
        gfx.rect(x+(w/2-.5), y+h-5 , 1, 5,1)
         
        gfx.rect(x+(w/4), y+5, 1, h-10,1)
        gfx.rect(x+(w/1.35), y+5, 1, h-10,1)
        
        gfx.rect(x+(w/2-.5), y+10 , 1, h-20,1)
        -----
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    -------------------------------------
    --]]
    
    
    
    
    
    
    
    
    
    
    
    
    
