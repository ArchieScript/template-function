









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
    
    
    
    ---------------------------------
    local function gradient(buf,vertically,x,y,w,h,white,black,alfa,col,brightness,frame);
        if h <= 5 then h = 0 end;
        if w <= 5 then w = 0 end;
        buf = tonumber(buf)or 948;if buf<0 then buf=0 end;if buf>1023 then buf=1023 end;
        local b = brightness;
        alfa = tonumber(alfa)or 1;
        if alfa < 0 then alfa = 0 elseif alfa > 1 then alfa = 1 end;
        if type(col) ~= "table" then;
            col = { {1,0,0},{1,0.25,0},{1,0.5,0},{1,0.75,0},{1,1,0},{0.75,1,0},{0.5,1,0},
                    {0.25,1,0},{0,1,0},{0,1,0.25},{0,1,0.5},{0,1,0.75},{0,1,1},{0,0.75,1},
                    {0,0.50,1},{0,0.25,1},{0.25,0,1},{0.5,0,1},{0.75,0,1},{1,0,1},{1,0,0.75},
                    {1,0,0.5},{1,0,0.25},{1,0,0} };
        end;
        -----
        for i = 1,#col do;
            for c = 1,3 do;
                col[i][c] = col[i][c]+b;
                if col[i][c]>1 then col[i][c]=1 end;
                if col[i][c]<0 then col[i][c]=0 end;
            end;
        end;
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
            ----
            if white == true then;
                local r = 1+b;
                if r < 0 then r = 0 elseif r > 1 then r = 1 end;
                gfx.gradrect(0,0,(#col-1)*10,100, r,r,r,1, 0,0,0,0, 0,0,0,-1/100);
            end;
            ----
            if black == true then;
                 local r = 0+b;
                 if r < 0 then r = 0 elseif r > 1 then r = 1 end;
                 gfx.gradrect(0,100,(#col-1)*10,100, r,r,r,0, 0,0,0,0, 0,0,0,1/100);
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
                local r = 0+b;
                if r < 0 then r = 0 elseif r > 1 then r = 1 end;
                gfx.gradrect(0,0,100,(#col-1)*10,r,r,r,1, 0,0,0,-1/100, 0,0,0,0);
            end;
            ----
            if black == true then;
                 local r = 1+b;
                 if r < 0 then r = 0 elseif r > 1 then r = 1 end;
                 gfx.gradrect(100,0,100,(#col-1)*10, r,r,r,0, 0,0,0,1/100, 0,0,0,0);
            end;
            -----
        end;
        gfx.dest = -1;
        gfx.a = alfa;
        if vertically == true then;
            x_s,y_s,w_s,h_s = 1,0,198,10*(#col-1);
        else;
            x_s,y_s,w_s,h_s = 0,1,10*(#col-1),198;
        end;
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
    ---------------------------------
    
    
    
    
    
    
    
    
    
    
