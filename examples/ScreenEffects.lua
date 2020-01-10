local ScreenImage = nil

function ShowBlood(image)
    ScreenImage.setImage("../../examples/resources/".. image)
end

function CreateOptionListDialog()


    local ImageStyle = UICSS()
    ImageStyle.left = "0px"
    ImageStyle.right = "0px"
    ImageStyle.top = "0px"
    ImageStyle.bottom = "0px"
    ImageStyle['background-position'] = "center center"

    --Create a image direct on the screen and not in a dialog
    ScreenImage = UIImage()
    ScreenImage.mode("cover")
    ScreenImage.setCSS(ImageStyle)
    ScreenImage.appendTo(UIFramework)


    --Create a dialog
    local dialog = UIDialog()
    --dialog.setCanClose(true)
    dialog.setTitle("Screen Effects")
    dialog.appendTo(UIFramework)
    dialog.onClickClose(function(obj)
        obj.hide()
    end)

    --Create a text
    local desc = UIText()
    desc.setContent("Please select a screen effect")
    desc.appendTo(dialog)

    --Create a option list
    local effectList = UIOptionList()
    effectList.appendOption("", "None");
    effectList.appendOption("death.png", "Death Screen");
    effectList.appendOption("blood_1.png", "Blood Screen 1");
    effectList.appendOption("blood_2.png", "Blood Screen 2");
    effectList.appendOption("blood_3.png", "Blood Screen 3");
    effectList.appendTo(dialog)
    effectList.onChange(function(obj)
        for _, value in pairs(obj.getValue()) do
            ShowBlood(value)
        end
    end)

    --Make the dialog globally available
    if GlobalDialogs ~= nil then
        GlobalDialogs["ScreenEffects"] = dialog

        --hide the dialog by default
        dialog.hide()
    end
end

AddEvent("OnUIFrameworkReady", CreateOptionListDialog)