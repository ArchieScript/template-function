




    Сравнить строки на совпадения



    local function CompareStrings(string,find_in_string )
        local user = string
        local find  = find_in_string
        if find:match(user)then func = true
        else func = false
        end return func
    end
