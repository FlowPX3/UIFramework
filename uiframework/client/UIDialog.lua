function UIDialog()
    local self = UIElement()

    self.options.type = "UIDialog"
    self.options.row = {}
    self.options.canClose = true
    self.options.movable = true
    self.options.titlecss = ""
    self.options.template = [[
        <div id="<%- id %>" class="ui-framework-parent dialog" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
            <div class="title" style="<% if (typeof titlecss != 'undefined') { %><%- titlecss %><% } %>">
                <%- title %>
                <% if (typeof canClose != 'undefined' && canClose) { %>
                    <div class="button-close"><i class="fas fa-times"></i></div>
                <% } %>
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


    function self.setMovable(value)
        self.options.movable = value
        self.update()
    end

    function self.setCanClose(value)
        self.options.canClose = value
        self.update()
    end

    -- css
    function self.setTitleCSS(value)
        self.options.titlecss = value.toString()
        self.update()
        return self
    end


    function self.update()
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")
        for _, child in pairs(self.children) do
            child.update()
        end
    end

    local counter = 0;
    function self.appendChild(child)
        table.insert(self.options.row, counter)
        table.insert(self.children, child)

        local cnt = -1
        for key,value in pairs(self.children) do
            cnt = cnt + 1
        end

        counter = counter + 1

        child.options.parent = self.options.id .. "-".. cnt
        self.update()
        return self
    end

    function self.setToScreenCenter()
        UIFramework.execute("setToScreenCenter('"..self.options.id.."');")
    end

    return self
end
