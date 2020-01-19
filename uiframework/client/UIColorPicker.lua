function UIColorPicker()
    local self = UIElement()

    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent ui-color-picker" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
            <input class="color" type="color" />
            <div class="title"><%- title %></div>    
        <div>
    ]]

    function self.getValueAsRGBA()
        local hex = self.getValue()
        hex = hex:gsub("#","")
        local r = tonumber("0x"..hex:sub(1,2))
        local g = tonumber("0x"..hex:sub(3,4))
        local b = tonumber("0x"..hex:sub(5,6))
        return r, g, b, 1
    end

    return self
end