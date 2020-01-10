function UIButton()
    local self = UIElement()

    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent button"><%- title %></div>
    ]]

    return self
end