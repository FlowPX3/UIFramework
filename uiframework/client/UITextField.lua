function UITextField()
    local self = UIElement()

    self.options.multiline = false
    self.options.template = [[
        <input <% if (typeof hideinput != 'undefined' && hideinput == true) { %>type="password"<% } %> id="<%- id %>" class="ui-framework-parent textfield" spellcheck="false" value="<%- value %>" placeholder="<%- placeholder %>" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
    ]]

    function self.setHideInput(value)
        self.options.hideinput = value
    end

    function self.setPlaceholder(placeholder)
        self.options.placeholder = placeholder
    end

    function self.getPlaceholder()
        return self.options.placeholder;
    end

    return self
end