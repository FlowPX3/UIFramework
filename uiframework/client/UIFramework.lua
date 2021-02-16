local AllUIFrameworkElements = {}

function AddUIFrameworkElement(e)
    table.insert(AllUIFrameworkElements, e)
end

function RemoveUIFrameworkElement(e)
    for i, v in ipairs(AllUIFrameworkElements) do
        if v.options.id == e.options.id then
            --AddPlayerChat("REMOVED ELEMENT")
            table.remove(AllUIFrameworkElements, i)
            break
        end
    end
end

function GetAllFrameworkElements()
    local tbl = {}
    for i, v in ipairs(AllUIFrameworkElements) do
        table.insert(tbl, v)
    end
    return tbl
end


local function UIFrameworkBase()
    local self = {
        id = "screen"
    }

    local ui = CreateWebUI(0, 0, 0, 0, 0, 32)
    SetWebVisibility(ui, WEB_VISIBLE)
    SetWebAnchors(ui, 0, 0, 1, 1)
    SetWebAlignment(ui, 0, 0)
    SetWebURL(ui, "http://asset/" .. GetPackageName() .. "/uiframework/ui/hud.html")


    local children = {}
    local private = {
        notifications = {},
        scale = 1
    }

    -- create a unique ID
    local counter = 0;
    function self.getNewID()
        counter = counter + 1
        return counter;
    end

    -- todo: notifications on the main screen
    function self.sendNotification(notification)
    end

    function self.execute(javascript)
        ExecuteWebJS(ui, javascript)
    end

    function self.appendChild(child)
        table.insert(children, child)
        child.options.parent = "screen"
        return self
    end

    function self.setScale(scale)
        private.scale = scale
    end

    function self.getScale()
            return private.scale
        end

    function self.show()
    end

    function self.hide()
    end

    function self.toggleVisibility()
    end

    function self.isVisible()
    end


    return self
end

function split_uif(str,sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    str:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
 end

UIFramework = UIFrameworkBase()
