local function UIFrameworkBase()
    local self = {}

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
        self.execute("appendChild(null, "..child.getObjectAsJSON()..");")
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

UIFramework = UIFrameworkBase()
