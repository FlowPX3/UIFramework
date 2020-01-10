function UIListView()
    local self = {}
    local private = {
        type = "UIListView",
        id = UIFramework.getNewID(),
        title = nil,
        content = nil,
        icon = nil,
        timeout = nil,
        template = [[
            <div id="<%- id %>" class="ui-framework-parent listview " style="padding: 5px;">
                <div children-container-for-id="<%- id %>" class="drag drop" style="height: 50px">
                </div>
                <div style="clear: both;"></div>
            </div>
        ]]
    }

    local children = {}

    function self.appendChild(child)
        table.insert(children, child)
        UIFramework.execute("appendChild('" .. private.id .. "', "..child.getObjectAsJSON()..");")
    end

    function self.setTitle(title)
        private.title = title
    end

    function self.getTitle()
        return private.title
    end

    function self.setContent(content)
        private.content = content
    end

    function self.getContent()
        return private.content
    end

    function self.getObjectAsJSON()
        return json_encode(private)
    end

    return self
end