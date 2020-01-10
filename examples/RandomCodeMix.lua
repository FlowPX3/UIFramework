-- Example how to use UIFramework

function MyItem(title, count, image)
    local data = {
        type = "MyItem",
        id = UIFramework.getNewID(),
        title = title,
        count = count,
        image = image,
        template = [[
            <div style="height: 80px; width: 80px; border-radius: 10px; background: rgb(124,133,142); color: white; float: left; margin: 5px; font-size: 10px; background-repeat: no-repeat; background-size: contain; background-image: url('<%- image %>');"><%- title %></div>
        ]]
    }

    local self = {}
    function self.getObjectAsJSON()
        return json_encode(data)
    end
    return self
end


AddEvent("OnUIFrameworkKeyPress", function(key)
    if key == "ESCAPE" then
        SetIgnoreLookInput(false)
        SetIgnoreMoveInput(false)
        ShowMouseCursor(false)
        SetInputMode(INPUT_GAME)
    end
end)


AddEvent("OnUIFrameworkReadyB", function(t)

    -- create a new UINotification instance and set some options
    --local notification = UINotification()
    --notification.setTitle("Notification example")
    --notification.setContent("Hello World! This is a example text notification.")

    -- send a notification
    --UIFramework.sendNotification(notification)

    local myDialog = UIDialog()
    myDialog.setTitle("New Dialog 1")
    UIFramework.appendChild(myDialog)

    --local myList = UIContainerList()
    --myDialog.appendChild(myList)


    --local myButton = UIButton()
    --myButton.setContent("Click here")
    --UIFramework.appendChild(myButton)


    local myGrid = UIGrid()
    myGrid.setHeader({"Column 1", "Column 2", "Column 3"})
    myGrid.appendRow({"Hello","world", ""})
    myGrid.appendRow({"No","Name", "!"})
    myGrid.appendRow({"More","Text", "!"})
    myGrid.appendRow({"More","Text", "!"})
    myGrid.appendRow({"More","Text", "!"})
    myGrid.appendRow({"More","Text", "!"})
    myGrid.appendTo(myDialog)




    local myTextField = UITextField()
    myTextField.setContent("Type here...")
    --myList.appendChild(myTextField)
    myGrid.appendChildToColumnAndRow(myTextField,2,0)


    local myProgress1 = UIProgressBar()
    myProgress1.setValue(25)
    myProgress1.setTitle("25 / 100")
    myDialog.appendChild(myProgress1)

    local myProgress2 = UIProgressBar()
    myProgress2.setValue(50)
    myProgress2.setTitle("50 / 100")
    myDialog.appendChild(myProgress2)

    local myProgress3 = UIProgressBar()
    myProgress3.setValue(75)
    myProgress3.setTitle("75 / 100")
    myDialog.appendChild(myProgress3)

    local buttonContainer = UIContainer()
    buttonContainer.setDirection("horizontal")
    myDialog.appendChild(buttonContainer)

    local myButtonA = UIButton()
    myButtonA.setContent("Ok")
    myButtonA.onClick(function(obj)
        AddPlayerChat("You clicked ".. obj.getTitle())
    end)
    buttonContainer.appendChild(myButtonA)

    local myButtonB = UIButton()
    myButtonB.setContent("Abbrechen")
    myButtonB.onClick(function(obj)
        AddPlayerChat("You clicked ".. obj.getTitle())
    end)
    buttonContainer.appendChild(myButtonB)


    local inventory = UIListView()
    myDialog.appendChild(inventory)
    inventory.appendChild(MyItem("Charater 1",3, "../../examples/resources/2.jpg"))
    inventory.appendChild(MyItem("Charater 2",3, "../../examples/resources/9.jpg"))
    inventory.appendChild(MyItem("Charater 3",3, "../../examples/resources/29.jpg"))


    local myDialogB = UIDialog()
    myDialogB.setTitle("New Dialog 2")
    myDialogB.setSize(800,400)
    UIFramework.appendChild(myDialogB)



    local myText = UIText()
    myText.setContent("Als bekanntester Blindtext gilt der Text \"Lorem ipsum\", der seinen Ursprung im 16. Jahrhundert haben soll. Lorem ipsum ist in einer pseudo-lateinischen Sprache verfasst, die ungefähr dem \"natürlichen\" Latein entspricht.")
    myDialogB.appendChild(myText)


    local myAccordion = UIAccordion()
    myDialogB.appendChild(myAccordion)

    local inventoryB = UIListView()
    myDialogB.appendChild(inventoryB)

end)


