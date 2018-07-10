


как сократить условие

if envelopeName == "Volume" or envelopeName == "Volume (Pre-FX)" or envelopeName == "Send Volume" or envelopeName == "Trim Volume" then
    bla()
end

---------------------------------------------------------






local function If_Equals(EqualsToThat,...)
    for _,v in ipairs {...} do
        if v == EqualsToThat then return true end
    end
    return false
end
---

if If_Equals(EqualsToThat,"Volume","Volume (Pre-FX)","Send Volume","Trim Volume") then
    bla()
end
