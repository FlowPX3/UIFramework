function UIOptionList()
    local self = UIElement()

    self.options.multiselection = false
    self.options.template = [[
        <select id="<%- id %>" class="ui-framework-parent ui-option-list" size="5" <% if (multiselection) { %> multiple="multiple" <% } %> style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
            <% list.forEach(function(item){ %>
                <option value="<%- item.value %>"><%- item.title %></option>
            <% }); %>
        </select>
    ]]

    self.options.list = {}

    function self.allowMultiselection(value)
        self.options.multiselection = value
    end

    function self.appendOption(value, title)
        local option = {}
        option["value"] = value

        if title ~= nil then
            option["title"] = title
        else
            option["title"] = value
        end
        table.insert(self.options.list, option)
    end

    function self.removeOption(value)
        local index = nil
        for i, val in ipairs (self.options.list) do
            if (val["value"] == value) then
              index = i
            end
        end

        if index ~= nil then
            table.remove(self.options.list, index)
        end

        --Update the the frontend
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")
    end

    function self.clear()
        self.options.list = {}

        --Update the the frontend
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")
    end


    return self
end