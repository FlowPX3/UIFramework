function UIText()
    local self = UIElement()

    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent ui-text" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>"><%- content %></div>
    ]]

    return self
end
