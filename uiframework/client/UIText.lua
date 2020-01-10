function UIText()
    local self = UIElement()

    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent ui-text"><%- content %></div>
    ]]

    return self
end