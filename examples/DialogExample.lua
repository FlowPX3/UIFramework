function CreateDialogExample()

    --Create a dialog
    local dialog = UIDialog()
    --dialog.setCanClose(true)
    dialog.setTitle("Dialog Example")
    dialog.appendTo(UIFramework)
    dialog.onClickClose(function(obj)
        obj.hide()
    end)

    --Create a text
    local desc = UIText()
    desc.setContent("If an element is destroyed, it can no longer be displayed.")
    desc.appendTo(dialog)

    --Create the "destroy" button
    local destroyButton = UIButton()
    destroyButton.setTitle("Destroy this dialog")
    destroyButton.onClick(function(obj)
        dialog.destroy()
    end)
    destroyButton.appendTo(dialog)

    --Create the "center" button
    local centerButton = UIButton()
    centerButton.setTitle("Center this dialog")
    centerButton.onClick(function(obj)
        dialog.setToScreenCenter()
    end)
    centerButton.appendTo(dialog)

    --Make the dialog globally available
    if GlobalDialogs ~= nil then
        GlobalDialogs["DialogExample"] = dialog

        --hide the dialog by default
        dialog.hide()
    end
end

AddEvent("OnUIFrameworkReady", CreateDialogExample)
