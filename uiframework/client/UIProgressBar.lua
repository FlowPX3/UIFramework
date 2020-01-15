function UIProgressBar()
    local self = {}
    local private = {
        type = "UIProgressBar",
        id = UIFramework.getNewID(),
        title = nil,
        value = 0,
        max = 100,
        template = [[
            <div id="<%- id %>" class="ui-framework-parent progressbar" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
                <div class="progress blue" style="width: <%- value %>%;"><div class="title"><%- title %></div></div>
            </div>
        ]]
    }

    function self.setValue(value)
        private.value = value
    end

    function self.getValue()
        return private.value
    end

    function self.setTitle(value)
        private.title = value
    end
    function self.getTitle()
        return private.title
    end

    function self.getObjectAsJSON()
        return json_encode(private)
    end

    --ToDo
    function self.setMaxValue(value)
        private.max = value
    end
    function self.getMaxValue()
        return private.max
    end

    return self
end