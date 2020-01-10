function UINotification()
    local self = {}
    local private = {
        title = nil,
        content = nil,
        icon = nil,
        timeout = nil
    }

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

    return self
end