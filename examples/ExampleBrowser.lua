GlobalDialogs = {}
ExampleBrowserDialog = nil

function CreateOptionListDialog()

    -- set position to right bottom for the help
    local helpStyle = UICSS()
    helpStyle['position'] = "absolute"
    helpStyle['right'] = "20px"
    helpStyle['bottom'] = "20px"

    --Create a text
    local help = UIText()
    help.setContent([[
        <h1>Info</h1>
        Press the key 'I' to toggle the example dialog visibility. <br>
        Press the key 'O' to toggle the debug console visibility.
    ]])
    help.setCSS(helpStyle)
    help.appendTo(UIFramework)

    --Set dialog size and position
    local ScreenX, ScreenY = GetScreenSize()
    local dialogPosition = UICSS()
    dialogPosition.top = "250px"
    dialogPosition.left = math.floor((ScreenX - 600) / 2) .. "px !important"
    dialogPosition.width = "600px"

    --Create a dialog
    ExampleBrowserDialog = UIDialog()
    ExampleBrowserDialog.setTitle("Example Browser")
    ExampleBrowserDialog.setCSS(dialogPosition)
    ExampleBrowserDialog.appendTo(UIFramework)
    ExampleBrowserDialog.onClickClose(function(obj)
        obj.hide()
    end)

    --Create a text
    local desc = UIText()
    desc.setContent("Press the key 'I' to toggle between UI and Game input or ESC to hide all Dialogs")
    desc.appendTo(ExampleBrowserDialog)

    --Create a text
    local title = UIText()
    title.setContent("Please select a dialog to show or hide")
    title.appendTo(ExampleBrowserDialog)

    --Create a option list
    local selectedDialogs = nil
    local dialogList = UIOptionList()
    dialogList.allowMultiselection(true)
    dialogList.appendOption("OptionList");
    dialogList.appendOption("ScreenEffects");
    dialogList.appendOption("WelcomeDialog");
    dialogList.appendOption("DialogExample");
    dialogList.appendOption("Container");

    
    dialogList.appendTo(ExampleBrowserDialog)
    dialogList.onChange(function(obj)
        selectedDialogs = obj.getValue()
    end)

    --Container to show the buttons horizontal and not vertical
    local buttonContainer = UIContainer()
    buttonContainer.setDirection("horizontal")
    buttonContainer.appendTo(ExampleBrowserDialog)


    --Create the "hide" button
    local hideButton = UIButton()
    hideButton.setTitle("Show dialog")
    hideButton.setType("primary")
    hideButton.onClick(function(obj)
        for _, value in pairs(selectedDialogs) do
            local dialog = GlobalDialogs[value]
            if dialog ~= nil then
                dialog.show()
                --center the dialog
                dialog.setToScreenCenter()
            end
        end
    end)
    hideButton.appendTo(buttonContainer)

    --Create the "show" button
    local showButton = UIButton()
    showButton.setTitle("Hide dialog")
    showButton.setType("secondary")
    showButton.onClick(function(obj)
        for _, value in pairs(selectedDialogs) do
            local dialog = GlobalDialogs[value]
            if dialog ~= nil then
                dialog.hide()
            end
        end
    end)
    showButton.appendTo(buttonContainer)

    
end

AddEvent("OnUIFrameworkReady", CreateOptionListDialog)


-- press key to toggle between UI or GAME Input 
local interfaceActive = false

function toggleUIMode()
    interfaceActive = not interfaceActive

    SetIgnoreLookInput(interfaceActive)
    SetIgnoreMoveInput(interfaceActive)
    ShowMouseCursor(interfaceActive)
    ShowChat(interfaceActive)
    
    --SetInputMode(INPUT_GAMEANDUI)

    if interfaceActive == true then
        if ExampleBrowserDialog ~= nil then
            ExampleBrowserDialog.show()
        end
        SetInputMode(INPUT_UI)
    else
        if ExampleBrowserDialog ~= nil then
            ExampleBrowserDialog.hide()
        end
        SetInputMode(INPUT_GAME)
    end
end

AddEvent("OnKeyPress", function(key)
    if key == "I" then
        toggleUIMode()
	end
end)

AddEvent("OnUIFrameworkKeyPress", function(key)
    if key == "I" then
        toggleUIMode()
	end

    if key == "ESCAPE" then
        interfaceActive = false
        SetIgnoreLookInput(false)
        SetIgnoreMoveInput(false)
        ShowMouseCursor(false)
        SetInputMode(INPUT_GAME)

        -- hide all dialogs
        if ExampleBrowserDialog ~= nil then
            ExampleBrowserDialog.hide()
        end
        for _,dialog in pairs(GlobalDialogs) do
            dialog.hide()
        end
    end
end)