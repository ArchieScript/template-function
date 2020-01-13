



    value = 1/4
    
    Dotted  = value+(value/2) -- .
    Triplet = value-(value/3) -- T




--------------

    local function SetGridMIDIEditor(midieditor,val,T);
        T = tostring(T):upper();
        if T == 'T' or T == 'TRIPLET' then;
            val = val-(val/3);
        elseif T == '.' or T == 'DOTTET' then;
            val = val+(val/2);
        end;
        reaper.SetMIDIEditorGrid(0,val); 
    end;

