
local function createCarDealermenu()
	local buycar
    local buycolor
    
    --Set dialog size and position
    local ScreenX, ScreenY = GetScreenSize()
    local dialogPosition = UICSS()
    dialogPosition.top = "250px"
    dialogPosition.left = math.floor((ScreenX - 600) / 2) .. "px !important"
    dialogPosition.width = "600px"

	local dialog = UIDialog()
	dialog.setTitle("Fahrzeug Händler")
    dialog.appendTo(UIFramework)
    dialog.setCSS(dialogPosition)
	dialog.onClickClose(function(obj)
        obj.hide()
    end)

    local button = UIButton()
    button.setTitle("Kaufen")
	button.onClick(function(obj)
    end)
    button.appendTo(dialog)
    
    local buttonb = UIButton()
    buttonb.setTitle("Kaufen")
    
	buttonb.onClick(function(obj)
    end)
    buttonb.appendTo(dialog)
    


    
    local comboContainer = UIContainer()
    comboContainer.setSizes({30,70})
    comboContainer.setDirection("horizontal")
    comboContainer.appendTo(dialog)

	local combobox = UIOptionList()
    for k,v in pairs({"1","2","3","4"}) do
        combobox.appendOption("1", "1")
    end
    combobox.appendTo(comboContainer)
    combobox.onChange(function(obj)
		for k,v in pairs(obj.getValue()) do
			buycar = v
        end
	end)

	local combobox1 = UIOptionList()
    for k,v in pairs({"1","2","3","4"}) do
        combobox1.appendOption("1","1")
    end
    combobox1.appendTo(comboContainer)
    combobox1.onChange(function(obj)
		for k,v in pairs(obj.getValue()) do
			buycolor = v
        end
	end)


    local buttonc = UIButton()
    buttonc.setTitle("Kaufen")
	buttonc.onClick(function(obj)
    end)
    buttonc.appendTo(dialog)
    
	
	--if GlobalDialogsD ~= nil then
	--	GlobalDialogsD["FahrzeugHandlerMenu"] = dialog
    --end
    
    
end

AddEvent("OnUIFrameworkReadyB", createCarDealermenu)





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

AddEvent("OnKeyPressD", function(key)
    if key == "I" then
        toggleUIMode()
	end
end)

AddEvent("OnUIFrameworkKeyPressD", function(key)
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