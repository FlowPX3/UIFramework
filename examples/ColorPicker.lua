function ColorPickerExample()
    local dialog = UIDialog()
    dialog.setTitle("Color Dialog")
    dialog.appendTo(UIFramework)
    dialog.onClickClose(function(obj)
        obj.hide()
    end)

    local hairColor = UIColorPicker()
    hairColor.setTitle("Choose your hair color")
    hairColor.appendTo(dialog)
    hairColor.onChange(function(obj, value)
        AddPlayerChat("Hair color '"..value.."'")
    end)

    local carColor = UIColorPicker()
    carColor.setTitle("Choose your car color")
    carColor.appendTo(dialog)
    carColor.onChange(function(obj)
        local r,g,b,a = carColor.getValueAsRGBA();
        AddPlayerChat("Car color '"..r..","..g..","..b..","..a.."'")
    end)

    --Make the dialog globally available
    if GlobalDialogs ~= nil then
        GlobalDialogs["ColorPicker"] = dialog

        --hide the dialog by default
        dialog.hide()
    end
end

AddEvent("OnUIFrameworkReady", ColorPickerExample)
