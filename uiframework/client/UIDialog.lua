function UIDialog()
    local self = UIElement()

    self.options.type = "UIDialog"
    self.options.row = {}
    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent dialog" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
            <div class="title">
                <%- title %>
                <div class="button-close"><i class="fas fa-times"></i></div>
            </div>
            <div>
                <table border="0" cellspacing="5">
                    <% row.forEach(function(index){ %>
                        <tr>
                            <td children-container-for-id="<%- id %>-<%- index %>" style=""></td>
                        </tr>
                    <% }); %>
                </table>
            </div>
        </div>
    ]]

    self.children = {}


    local counter = 0;
    function self.appendChild(child)
        table.insert(self.options.row, counter)
        table.insert(self.children, child)

        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")

        local cnt = 0
        for key,value in pairs(self.children) do
            UIFramework.execute("appendChild('" .. self.options.id .. "-".. cnt .."', "..value.getObjectAsJSON()..");")
            cnt = cnt + 1
        end

        counter = counter + 1  
    end

    function self.setToScreenCenter()
        UIFramework.execute("setToScreenCenter('"..self.options.id.."');")
    end

    return self
end
