hs.hotkey.bind(nil, "F15", function()
    local status = hs.http.get("https://thor.openmove.com/door", nil)
    if status == 200 then
        hs.alert.show("Door opened successfully")
    else
        hs.alert.show("Door opening failed")
    end
end)
