function CreateWelcomeDialog()

    --Create a new dialog
    local dialog = UIDialog()
    dialog.setTitle("Welcome Dialog")
    dialog.appendTo(UIFramework)
    dialog.onClickClose(function(obj)
        obj.hide()
    end)

    --Create a new text
    local text = UIText()
    text.setContent([[
        <h1>Welcome on our <span style="color: #b2422e;">O</span>nset server</h1>
        Nice that you want to play on our server, <br>
        but first you have to register. <br>
        For this we need a name for your character.
    ]])
    text.appendTo(dialog)

    --Create a new text field
    local firstNameInput = UITextField()
    firstNameInput.setPlaceholder("First name")
    firstNameInput.appendTo(dialog)

    --Create another text field
    local lastNameInput = UITextField()
    lastNameInput.setPlaceholder("Last name")
    lastNameInput.appendTo(dialog)

    --Create the "ok" button
    local okButton = UIButton()
    okButton.setTitle("OK")
    okButton.onClick(function(obj)
        AddPlayerChat("Welcome " .. firstNameInput.getValue() .. " "..lastNameInput.getValue())
    end)
    okButton.appendTo(dialog)

    --Make the dialog globally available
    if GlobalDialogs ~= nil then
        GlobalDialogs["WelcomeDialog"] = dialog

        --hide the dialog by default
        dialog.hide()
    end
end

AddEvent("OnUIFrameworkReady", CreateWelcomeDialog)
