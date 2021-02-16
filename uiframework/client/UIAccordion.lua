function UIAccordion()
    local self = {}
    local private = {
        type = "UIAccordion",
        id = UIFramework.getNewID(),
        row = {},
        direction = "vertical",
        template = [[
            <div id="<%- id %>" class="ui-framework-parent accordion">
                <h3>title</h3>
                <div class="">

                </div>
            </div>
        ]]
    }

    local counter = 0;
    local children = {}

    function self.setDirection(direction)
        private.direction = direction
    end

    function self.appendChild(child)
        table.insert(private.row, counter)
        table.insert(children, child)
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")

        local cnt = 0
        for key,value in pairs(children) do
            UIFramework.execute("appendChild('" .. private.id .. "-".. cnt .."', "..value.getObjectAsJSON()..");")
            cnt = cnt + 1
        end

        counter = counter + 1
    end

    function self.removeChild(child)
        for key,value in pairs(self.children) do
            if value.options.id == child.options.id then
                table.remove(self.children, key)
                break
            end
        end

        local cnt = -1
        for key,value in pairs(self.children) do
            value.options.parent = self.options.id .. "-".. cnt
            cnt = cnt + 1
        end

        counter = counter - 1
        table.remove(self.options.row, #self.options.row)
        self.update()
        return self
    end

    function self.getObjectAsJSON()
        return json_encode(private)
    end

    return self
end


