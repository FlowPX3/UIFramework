function UICSS()
    local self = {
        position = "absolute",
        left = nil,
        top = nil,
        width = nil,
        height = nil,
        right = nil,
        bottom = nil
    }

    function self.toString()
        local string = ""
        for k, v in pairs(self) do
            if type(k) == 'string' and type(v) == 'string' then
                string = string .. k .. ": " .. v .."; "
            end

        end
        return string
    end

    function self.set(key, value)
        self[key] = value
        return self
    end

    return self
end