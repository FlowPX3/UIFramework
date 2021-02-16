function UIContainer()
    local self = UIElement()

    self.options.type = "UIContainer"
    self.options.row = {}
    self.options.direction = "vertical"
    self.options.template = [[
        <table id="<%- id %>" class="ui-framework-parent" border="0" cellspacing="0" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">

            <% if(direction == "horizontal"){ %>
                <tr>
                    <% row.forEach(function(index){ %>
                        <td <% if (typeof sizes != 'undefined' && typeof sizes[index] != 'undefined') { %>width="<%- sizes[index] %>"<% } %> children-container-for-id="<%- id %>-<%- index %>" style=""></td>
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
    self.options.sizes = nil

    function self.setSizes(sizes)
        self.options.sizes = sizes
    end

    function self.setDirection(direction)
        self.options.direction = direction
    end

    function self.update()
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")
        for _, child in pairs(self.children) do
            child.update()
        end
    end

    local counter = 0;
    function self.appendChild(child)
        table.insert(self.options.row, counter)
        table.insert(self.children, child)

        local cnt = -1
        for key,value in pairs(self.children) do
            cnt = cnt + 1
        end

        counter = counter + 1

        child.options.parent = self.options.id .. "-".. cnt
        self.update()
        return self
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

    return self
end