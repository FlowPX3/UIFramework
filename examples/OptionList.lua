local greetings = {}
greetings["en"] = "Hello, do you speak English?"
greetings["de"] = "Hallo, Sie sprechen Deutsch?"
greetings["ru"] = "Здравствуйте, вы говорите по-русски?"

function CreateOptionListDialog()

    --Create a dialog
    local dialog = UIDialog()
    dialog.setTitle("Option List")
    dialog.appendTo(UIFramework)
    dialog.onClickClose(function(obj)
        obj.hide()
    end)

    --Create a text
    local languageTitle = UIText()
    languageTitle.setContent("Please select a number or more")
    languageTitle.appendTo(dialog)

    --Create a option list
    local optionList = UIOptionList()
    optionList.allowMultiselection(true)
    optionList.appendOption(0, "Zero");
    optionList.appendOption(1, "One");
    optionList.appendOption(2, "Two");
    optionList.appendOption(3, "Three");
    optionList.appendOption(4, "Four");
    optionList.appendOption(5, "Five");
    optionList.appendOption(6, "Six");
    optionList.appendOption(7, "Seven");
    optionList.appendOption(8, "Eight");
    optionList.appendOption(9, "Nine");
    optionList.appendOption(10, "Ten");
    optionList.appendTo(dialog)
    optionList.onChange(function(obj)
        for _, value in pairs(obj.getValue()) do
            AddPlayerChat("Your selected the item with the value '"..value.."'")
        end
    end)

    --Create a text
    local languageTitle = UIText()
    languageTitle.setContent("Please select a language")
    languageTitle.appendTo(dialog)

    --Create a option list
    local selectedItems = nil
    local languageList = UIOptionList()
    languageList.appendOption("en", "English");
    languageList.appendOption("de", "Deutsch");
    languageList.appendOption("ru", "Русский");
    languageList.appendTo(dialog)
    languageList.onChange(function(obj)

        --this line is to remove later the selected items
        selectedItems = obj.getValue()

        for _, value in pairs(obj.getValue()) do
            AddPlayerChat(greetings[value])
        end
    end)

    --Create the "clear" button
    local okButton = UIButton()
    okButton.setTitle("Clear language list")
    okButton.onClick(function(obj)
        languageList.clear()
    end)
    okButton.appendTo(dialog)

    --Create the "remove" button
    local okButton = UIButton()
    okButton.setTitle("Remove selected items")
    okButton.onClick(function(obj)
        for _, value in pairs(selectedItems) do
            languageList.removeOption(value)
        end
    end)
    okButton.appendTo(dialog)

    --Make the dialog globally available
    if GlobalDialogs ~= nil then
        GlobalDialogs["OptionList"] = dialog

        --hide the dialog by default
        dialog.hide()
    end
end

AddEvent("OnUIFrameworkReady", CreateOptionListDialog)