   
   
   
   
   
   
    
    function ClearEnvelopeInTimeInterval(env,time1,time2,interval);
        local leftPoint  = reaper.GetEnvelopePointByTimeEx(env,-1,time1-0.00001);
        local RightPoint = reaper.GetEnvelopePointByTimeEx(env,-1,time2+0.00001);
        local timeEnd,check;
        for i = RightPoint,leftPoint,-1 do;
            local timeR = ({reaper.GetEnvelopePoint(env,i-0)})[2];
            local timeC = ({reaper.GetEnvelopePoint(env,i-1)})[2];
            local timeL = ({reaper.GetEnvelopePoint(env,i-2)})[2];
            if (timeR - timeL) <= interval then;
                if not check then;
                    timeEnd = ({reaper.GetEnvelopePoint(env,reaper.CountEnvelopePoints(env)-1)})[2]+10^2;
                    check = true;
                end;
                reaper.SetEnvelopePoint(env,i-1,timeEnd,0,0,0,0,true);
                reaper.DeleteEnvelopePointRange(env,timeEnd-0.001,timeEnd+0.001);
            end;
        end;
        if check then reaper.Envelope_SortPoints(env)end;
    end;

    -- env envelope Track
    -- time1, time2: Интервал с какого по какое время чистить огибающую.
    -- interval: интервал между 1 и 3 точкой, если время между 1 и 3 точкой меньше interval, то удалить точку 2.
    -- https://avatars.mds.yandex.net/get-pdb/1936330/4f976537-e217-4618-8e23-486a0fa0f4ca/s1200
    --====End===============End===============End===============End===============End====
