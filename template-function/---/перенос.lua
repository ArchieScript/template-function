


    
    
    
    
    
   --[
    t={{h=20,w=21,r=.9,g=.9,b=.9,a=1},
       {h=21,w=32,r=.2,g=.2,b=.8,a=1},
       {h=22,w=43,r=.3,g=.3,b=.7,a=1},
       {h=23,w=54,r=.4,g=.4,b=.6,a=1},
       {h=24,w=65,r=.5,g=.5,b=.5,a=1},
       {h=25,w=76,r=.6,g=.6,b=.4,a=1},
       {h=26,w=87,r=.7,g=.7,b=.3,a=1},
       {h=27,w=28,r=.8,g=.8,b=.2,a=1},
       {h=28,w=20,r=.9,g=.9,b=.1,a=1},
       {h=29,w=20,r=.1,g=.8,b=.5,a=1},
       {h=20,w=20,r=.2,g=.7,b=.1,a=1},
       {h=20,w=20,r=.3,g=.6,b=.4,a=1},
       {h=20,w=20,r=.4,g=.5,b=.1,a=1},
       {h=20,w=20,r=.5,g=.4,b=.3,a=1},
       {h=20,w=20,r=.6,g=.3,b=.1,a=1},
       {h=20,w=20,r=.7,g=.2,b=.2,a=1},
       {h=20,w=20,r=.8,g=.1,b=.1,a=1}, 
      }
    
    
    gfx.init("title",550,35,0,80,100);
    
    
   
    
    local function loop()
        
         
         
         X=0
         Y=0
         H2=0
         --H=20
         
      --   X2=X
       --  Y2=Y
       --  W2=W
       --  H2=H
         
         --TT={}
         for i = 1,#t do;
        
             
             --TT[i]={x=X2,y=Y2,w=W2,h=H2}
             
             
             
             
             gfx.gradrect(X,Y, t[i].w,t[i].h,  t[i].r,t[i].g,t[i].b,t[i].a);
             
             X2 =((t[i].w or 0))
             
             H2 = H2 or 0
             
             if (H2 or 0)< t[i].h then H2 = t[i].h end
             
             
             if (X+ (X2*2) ) <= gfx.w then
                 X = X+X2
             else
                 X = 0
                 Y = Y + H2 
             end
             
        
         end
        
        
        
        
        reaper.defer(loop)
    end
    
    
    loop()
    --]]
   
   
   
   
   
   
   
   
   
   
   
   
   
   --[[ 
    t={{1,1,1,1},{.3,.8,.5,1},{.2,.2,.2,1},{.3,.5,.7,1},{.7,.7,.2,1},
       {2,1,1,1},{.4,.9,.5,1},{.4,.3,.2,1},{.4,.6,.7,1},{.4,.6,.2,1},
       {3,1,1,1},{.5,.7,.5,1},{.5,.4,.2,1},{.5,.7,.7,1},{.5,.5,.2,1}, 
      }
    
    
    gfx.init("title",550,35,0,80,100);
    
    
  
    
    local function loop()
        
         
         
         X=0
         Y=0
         W=20
         H=20
         
         X2=X
         Y2=Y
         W2=W
         H2=H
         
         --TT={}
         for i = 1,#t do;
        
             
             --TT[i]={x=X2,y=Y2,w=W2,h=H2}
             
             gfx.gradrect(X2,Y2,W2,H2,  t[i][1],t[i][2],t[i][3],t[i][4]);
             
             
             
             if (X2+W2+W2) <= gfx.w then
                 X2 = X2+W2
             else
                 X2 = X
                 Y2 = Y2+H
             end
             
        
         end
        
        
        
        
        reaper.defer(loop)
    end
    
    
    loop()
    --]]
    
