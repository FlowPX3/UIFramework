function UIImage()
    local self = UIElement()

    self.options.mode = "contain"
    self.options.template = [[
        <div id="<%- id %>" class="ui-image" style="background-image: url('<%- image %>'); background-size: <%- mode %>; <% if (typeof css != 'undefined') { %><%- css %><% } %> "></div>
    ]]


    -- contain or cover
    function self.mode(value)
        self.options.mode = value
    end

    function self.setHeight(height)
        self.options.height = height
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")
    end

    function self.setImage(imagePath)
        self.options.image = imagePath
        UIFramework.execute("updateObject("..self.getObjectAsJSON()..");")
    end

    function self.getImage(imagePath)
        return self.options.image;
    end

    return self
end