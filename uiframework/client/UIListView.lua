function UIListView()
    local self = UIElement()

    self.options.type = "UIListView"
    self.options.height = 500
    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent listview " style="padding: 5px;" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
            <div children-container-for-id="<%- id %>" class="drag drop" style="height: <%- height %>px">
            </div>
            <div style="clear: both;"></div>
        </div>
    ]]

    function self.setHeight(height)
        self.options.height = height
    end

    return self
end