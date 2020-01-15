function UIGrid()
    local self = {}
    local private = {
        type = "UIGrid",
        id = UIFramework.getNewID(),
        title = nil,
        content = nil,
        icon = nil,
        timeout = nil,
        rows = {},
        header = {},
        template = [[
            <table id="<%- id %>" class="ui-framework-parent" border="0" cellspacing="1" style="<% if (typeof css != 'undefined') { %><%- css %><% } %>">
                <thead>
                    <tr>
                        <% header.forEach(function(column){ %>
                            <th style="background: rgba(33,83,148,1); color: white; padding: 5px; font-weight: normal;"><%- column %></th>
                        <% }); %>
                    </tr>
                </thead>
                <tbody>
                <% rows.forEach(function(row, rowIndex){ %>
                    <tr>
                        <% row.forEach(function(column, columnIndex){ %>
                            <td style="background: white;" children-container-for-id="<%- id %>-<%- columnIndex %>-<%- rowIndex %>"><%- column %></td>
                        <% }); %>
                    </tr>
                <% }); %>
                </tbody>
            </table>
        ]]
    }

    function self.appendChildToColumnAndRow(child, column, row)
        UIFramework.execute("appendChild('" .. private.id .. "-".. column .."-".. row .. "', "..child.getObjectAsJSON()..");")
    end

    function self.setHeader(header)
        private.header = header
    end

    function self.appendRow(row)
        table.insert(private.rows, row)
    end

    function self.setTitle(title)
        private.title = title
    end

    function self.getTitle()
        return private.title;
    end

    function self.setContent(content)
        private.content = content
    end

    function self.getContent()
        return private.content;
    end

    function self.getObjectAsJSON()
        return json_encode(private)
    end

    function self.appendTo(parent)
        parent.appendChild(self)
    end

    return self
end