function UIButton()
    local self = UIElement()

    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent button <%- type %>" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>"><%- title %></div>
    ]]
    self.options.type = ""

    function self.setType(type)
        self.options.type = type
    end

    return self
end