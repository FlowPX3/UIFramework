function UIContainer()
    local self = UIElement()

    self.options.type = "UIContainer"
    self.options.row = {}
    self.options.direction = "vertical"
    self.options.template = [[
        <table id="<%- id %>" class="ui-framework-parent" border="0" cellspacing="0">

            <% if(direction == "horizontal"){ %>
                <tr>
                    <% row.forEach(function(index){ %>
                        <td children-container-for-id="<%- id %>-<%- index %>" style=""></td>
                    <% }); %>
                </tr>
            <% } else { %>
                <% row.forEach(function(index){ %>
                    <tr>
                        <td children-container-for-id="<%- id %>-<%- index %>" style=""></td>
                    </tr>
                <% }); %>
            <% } %>
        </table>
    ]]
    self.children = {}

    function self.setDirection(direction)
        self.options.direction = direction
    end

    local counter = 0;
    function self.appendChild(child)
        table.insert(self.options.row, counter)
        table.insert(self.children, child)
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")

        local cnt = 0
        for key,value in pairs(self.children) do
            UIFramework.execute("appendChild('" .. self.options.id .. "-".. cnt .."', "..value.getObjectAsJSON()..");")
            cnt = cnt + 1
        end

        counter = counter + 1
    end

    return self
end