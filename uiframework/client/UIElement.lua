function UIElement()
    local self = {}
    self.options = {
        theme = "default",
        type = "UIElement",
        id = UIFramework.getNewID(),
        parent = nil,
        title = "",
        content = nil,
        placeholder = "",
        value = "",
        visible = true,
        css = nil,
        template = [[
            <div id="<%- id %>" class="ui-framework-parent" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>"></div>
        ]]
    }
    self.children = {}



    -- helper
    function booleanToString(bool)
        if bool then
            return "true"
        else
            return "false"
        end
    end

    -- events
    self.events = {}

    function self.onClick(func)
        self.events.click = func
        return self
    end

    function self.onChange(func)
        self.events.change = func
        return self
    end

    function self.onClickClose(func)
        self.events.clickClose = func
        return self
    end

    AddEvent("OnUIFrameworkEvent", function(objectId, eventType)
        if self ~= nil and tonumber(objectId) == tonumber(self.options.id) and eventType == "click" then
            if self.events.click ~= nil then
                self.events.click(self)
            end
        end
    end)

    AddEvent("OnUIFrameworkEvent", function(objectId, eventType, valueType, value)
        if self ~= nil and tonumber(objectId) == tonumber(self.options.id) and eventType == "close-dialog" then
            if self.events.clickClose ~= nil then
                self.events.clickClose(self)
            end
        end
    end)

    AddEvent("OnUIFrameworkEvent", function(objectId, eventType, valueType, value)
        if self ~= nil and tonumber(objectId) == tonumber(self.options.id) and eventType == "change" then

            if valueType == "array" then
                self.options.value = json_decode(value)
                if self.events.change ~= nil then
                    self.events.change(self, self.options.value)
                end
            end

            if valueType == "bool" then
                if tonumber(value) == 1 then
                    self.options.value = true
                else
                    self.options.value = false
                end

                if self.events.change ~= nil then
                    self.events.change(self, self.options.value)
                end
            end

            if valueType == "string" then
                self.options.value = value
                if self.events.change ~= nil then
                    self.events.change(self, self.options.value)
                end
            end
        end
    end)

    -- css
    function self.setCSS(value)
        self.options.css = value.toString()
    end

    -- title
    function self.setTitle(title)
        self.options.title = title
        return self
    end

    function self.getTitle()
        return self.options.title;
    end

    -- content
    function self.setContent(content)
        self.options.content = content
        return self
    end

    function self.getContent()
        return self.options.content;
    end

    -- value
    function self.setValue(value)
        self.options.value = value
        return self
    end

    function self.getValue()
        return self.options.value;
    end

    -- visibility
    function self.show()
        self.setVisibility(true)
        return self
    end

    function self.hide()
        self.setVisibility(false)
        return self
    end

    function self.setVisibility(visible)
        self.options.visible = visible
        UIFramework.execute("setVisibility("..self.getObjectAsJSON()..", ".. booleanToString(self.options.visible) .. ");")
    end

    function self.isVisible()
        return self.options.visible
    end

    function self.destroy()
        UIFramework.execute("destroyObject("..self.options.id..")")
        self = nil
    end

    -- get private values as a json object
    function self.getObjectAsJSON()
        return json_encode(self.options)
    end

    function self.appendTo(parent)
        parent.appendChild(self)
        return self
    end

    function self.update()
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")
        for _, child in pairs(self.children) do
            child.update()
        end
    end

    function self.appendChild(child)
        table.insert(self.children, child)
        child.options.parent = self.options.id
        self.update()
        return self
    end

    return self
end