









    -- нарисовать градиент
    
    -- buf 0..1023 / не обязательный параметр, по умолчанию 948
    -- vertically  / true вертикаль, false горизонталь
    -- x,y,w,h     / в пикселях
    -- white       / true включить белую полосу
    -- black       / true включить черную полосу
    -- alfa        / прозрачность 0..1
    -- col         / не обязательный параметр,по умолчанию все цвета радуги
    --               Переназначение в виде {{0,0,0},{.5,.5,.5},{1,1,1}}
    -- brightness  / яркость -1..1
    -- frame       / рамка nil или установить в виде {1,1,1,1,1} / {толщина рамки,r,g,b,a}
    -- UnColGrd   / UnColored Gradient  true включить Неокрашенный Градиент при максимальной, минимальной яркасти (brightness)
    
    
    --====================================================================
    local function gradient(buf,vertically,x,y,w,h,white,black,alfa,col,brightness,frame,UnColGrd);
        if h <= 5 then h = 0 end;
        if w <= 5 then w = 0 end;
        buf = tonumber(buf)or 948;if buf<0 then buf=0 end;if buf>1023 then buf=1023 end;
        local b = brightness;
        if b < -1 then b = -1 elseif b > 1 then b = 1 end;
        alfa = tonumber(alfa)or 1;
        if alfa < 0 then alfa = 0 elseif alfa > 1 then alfa = 1 end;
        if type(col) ~= "table" or type(col[1])~= "table" then;
            col =  {{1,1,1},{1,1,1},{1,.9,.9},{1,.8,.8},{1,.7,.7},{1,.6,.6},{1,.5,.5},{1,.4,.4},{1,.3,.3},{1,.2,.2},{1,.1,.1},
                   {1,0,0},{1,.1,0},{1,.2,0},{1,.3,0},{1,.4,0},{1,.5,0},{1,.6,0},{1,.7,0},{1,.8,0},{1,.9,0},
                   {1,1,0},{.9,1,0},{.8,1,0},{.7,1,0},{.6,1,0},{.5,1,0},{.4,1,0},{.3,1,0},{.2,1,0},{.1,1,0},
                   {0,1,0},{0,1,.1},{0,1,.2},{0,1,.3},{0,1,.4},{0,1,.5},{0,1,.6},{0,1,.7},{0,1,.8},{0,1,.9},
                   {0,1,1},{0,.9,1},{0,.8,1},{0,.7,1},{0,.6,1},{0,.5,1},{0,.4,1},{0,.3,1},{0,.2,1},{0,.1,1},
                   {0,0,1},{.1,0,1},{.2,0,1},{.3,0,1},{.4,0,1},{.5,0,1},{.6,0,1},{.7,0,1},{.8,0,1},{.9,0,1},
                   {1,0,1},{1,0,.9},{1,0,.8},{1,0,.7},{1,0,.6},{1,0,.5},{1,0,.4},{1,0,.3},{1,0,.2},{1,0,.1},
                   {1,0,0},{.9,0,0},{.8,0,0},{.7,0,0},{.6,0,0},{.5,0,0},{.4,0,0},{.3,0,0},{.2,0,0},{.1,0,0},{0,0,0},{0,0,0}};
        end;
        if #col == 1 then col[2] = col[1] end;
        -----
        local gfx_r,gfx_g,gfx_b,gfx_a = gfx.r,gfx.g,gfx.b,gfx.a;
        gfx.dest = buf;
        gfx.setimgdim(buf,-1,-1);
        local x_s,y_s,w_s,h_s;
        if vertically == true then;
            w_s,h_s = 200,10*(#col-1);
        else;
            w_s,h_s=10*(#col-1),200;
        end;
        gfx.setimgdim(buf,w_s,h_s);
        gfx.a = 1;
        -----
        if vertically ~= true then;
            ----
            for i = 1,#col-1 do;
                gfx.gradrect(0+10*(i-1), 0, 10, 200,
                             col[i][1],col[i][2],col[i][3], 1,
                             ((col[i+1][1])-(col[i][1])) / 10,
                             ((col[i+1][2])-(col[i][2])) / 10,
                             ((col[i+1][3])-(col[i][3])) / 10,
                             0);
            end;
            -----
            ----- 
            if white == true then;
                local rw = b+1;
                if rw > 1 then rw = 1 elseif rw < 0 then rw = 0 end;
                gfx.gradrect(0,0,(#col-1)*10,5, rw,rw,rw,1);
                gfx.gradrect(0,5,(#col-1)*10,95, rw,rw,rw,1, 0,0,0,0, 0,0,0,(0-1)/(95));
            end;
            if black == true then;
                local rb = b;
                if rb > 1 then rb = 1 elseif rb < 0 then rb = 0 end;
                gfx.gradrect(0,195,(#col-1)*10,5, rb,rb,rb,1);
                gfx.gradrect(0,100,(#col-1)*10,95, rb,rb,rb,0, 0,0,0,0, 0,0,0,1/(95));
            end;
            ----
            local rwa = b;
            if white == true then rwa = rwa*2-1 end;
            if rwa < 0 then rwa = 0 elseif rwa > 1 then rwa = 1 end;
            gfx.gradrect(0,0,(#col-1)*10,200,1,1,1,rwa);
            ----
            local rba = b-b*2;
            if black == true then rba = (rba*2-1)end;
            if rba < 0 then rba = 0 elseif rba > 1 then rba = 1 end;
            gfx.gradrect(0,0,(#col-1)*10,200,0,0,0,rba);
            -----
            if UnColGrd == true then;
                gfx.gradrect(0,0,(#col-1)*10,200, rba,rba,rba,rba,
                             -1/((#col-1)*10),-1/((#col-1)*10),-1/((#col-1)*10),0,
                             -1/(200),-1/(200),-1/(200),0);
                local clr = (b-b*2)+1;
                if clr < 0 then clr = 0 elseif clr > 1 then clr = 1 end;
                gfx.gradrect(0,0,(#col-1)*10,200,clr,clr,clr,rwa,
                             1/((#col-1)*10),1/((#col-1)*10),1/((#col-1)*10),0,
                             1/(200),1/(200),1/(200),0);
            end;
            -----
        else;
            -----
            for i = 1,#col-1 do;
                gfx.gradrect(0,10*(i-1),200,10,
                             col[i][1],col[i][2],col[i][3],1, 0,0,0,0,
                             ((col[i+1][1])-(col[i][1])) / 10,
                             ((col[i+1][2])-(col[i][2])) / 10,
                             ((col[i+1][3])-(col[i][3])) / 10, 0);
            end;
            ----
            if white == true then;
                local rw = b+1;
                if rw < 0 then rw = 0 elseif rw > 1 then rw = 1 end;
                gfx.gradrect(195,0,5,(#col-1)*10, rw,rw,rw,1);
                gfx.gradrect(100,0,95,(#col-1)*10, rw,rw,rw,0, 0,0,0,1/95, 0,0,0,0);
            end;
            if black == true then;
                local rb = b;
                if rb > 1 then rb = 1 elseif rb < 0 then rb = 0 end;
                gfx.gradrect(0,0,5,(#col-1)*10, rb,rb,rb,1);
                gfx.gradrect(0,0,95,(#col-1)*10, rb,rb,rb,1, 0,0,0,(0-1)/95, 0,0,0,0);
            end;
            ----
            local rwa = b;
            if white == true then rwa = rwa*2-1 end;
            if rwa < 0 then rwa = 0 elseif rwa > 1 then rwa = 1 end;
            gfx.gradrect(0,0,200,(#col-1)*10,1,1,1,rwa);
            ----
            local rba = b-b*2;
            if black == true then rba = (rba*2-1)end;
            if rba < 0 then rba = 0 elseif rba > 1 then rba = 1 end;
            gfx.gradrect(0,0,200,(#col-1)*10,0,0,0,rba);
            ----
            if UnColGrd == true then;
                local clr = (b-b*2)+1;
                if clr < 0 then clr = 0 elseif clr > 1 then clr = 1 end;
                gfx.gradrect(0,0,200,(#col-1)*10, clr,clr,clr,rwa,
                             1/200,1/200,1/200,0,
                             1/((#col-1)*10),1/((#col-1)*10),1/((#col-1)*10),0);
                gfx.gradrect(0,0,200,(#col-1)*10,rba,rba,rba,rba,
                             -1/200,-1/200,-1/200,0,
                             -1/((#col-1)*10),-1/((#col-1)*10),-1/((#col-1)*10),0);
            end;
            ----
        end;
        gfx.dest = -1;
        gfx.a = alfa;
        if vertically == true then;
            x_s,y_s,w_s,h_s = 1,0,198,10*(#col-1);
        else;
            x_s,y_s,w_s,h_s = 0,1,10*(#col-1),198;
        end;
        
        local rgb = (b+1)/2;
        gfx.gradrect(x,y,w,h, rgb,rgb,rgb,alfa);
        
        gfx.blit(buf,1,0, x_s,y_s,w_s,h_s, x,y,w,h, 0,0);
        ----
        if type(frame)~="table" then frame = {} end;
        gfx.r,gfx.g,gfx.b,gfx.a = frame[2]or 0,frame[3]or 0,frame[4]or 0,frame[5]or 0;
        gfx.a = math.min(math.max(0,gfx.a),1);
        for i = 1,(frame[1]or 1) do;
            gfx.roundrect( x+(i-1) , y+(i-1), w-((i-1)*2) , h-((i-1)*2), 1);
        end;
        ---
        gfx.r,gfx.g,gfx.b,gfx.a = gfx_r,gfx_g,gfx_b,gfx_a;
    end;
    --====================================================================
    
    
    
    
    
