function UICheckBox()
    local self = UIElement()

    self.options.type = "UICheckBox"
    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent checkbox" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
            <label>
                <input type="checkbox" />
                <i class="checkbox-helper"></i>
                <span><%- title %></span>
            </label>
        </div>
    ]]

    return self
end