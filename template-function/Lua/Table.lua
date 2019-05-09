









    --/ Искать в таблице значение /--
    
    function SearchTable(table, val);
        for k, v in pairs(table) do;
            if v == val then return true end;
        end;
        return false;
    end;  
    ---------------------------------
 
 
 
 
 
 
 
    -------- / Сравнить две таблицы / --------
    
    function ComparedTwoTables(table1, table2) 
        if #table1 ~= #table2 then return false end;
       
        for key, val in pairs(table1) do
            if table2[key] ~= val then
                return false
            end
        end
        return true
    end
    ------------------------------------------
