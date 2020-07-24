








    local function genNumb(str)
        for i = 1,#str do
            x = str:byte(i);
            x2=(x2 or '')..x
        end;
        return x2;
    end;
