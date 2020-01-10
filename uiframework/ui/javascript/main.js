function setVisibility(objectId, visibility) {
    if (visibility) {
        $("#" + objectId).show();
    } else {
        $("#" + objectId).hide();
    }
}

function destroyObject(objectId) {
    $('#' + objectId).remove();
}


function setToScreenCenter(ObjectId) {
    let dialog = $('#' + ObjectId);
    dialog.css ("top", ($('#screen').height() - dialog.height()) / 2 + "px");
    dialog.css ("left", ($('#screen').width() - dialog.width()) / 2 + "px")
}

function updateObject(object) {
    let id = $("#" + object.id).parent().closest('[children-container-for-id]').attr('children-container-for-id');
    $('#' + object.id).remove();

    
    /*
    if(object.type == "UIContainer") {
        console.log("o id: " + object.id);
        console.log("id: " + id);
        console.log("updateObject: " + JSON.stringify(object));
    }
    */

    

    let parentObject = $('#screen');
    if (id != null) {
        parentObject = $("[children-container-for-id='" + id + "']")
    }

    if (typeof object.template != "undefined") {
        let dialog = ejs.render(object.template, object);
        parentObject.append(dialog);
    }

    $(".dialog").draggable({handle: "> .title"});
    $(".drag").sortable({
        connectWith: ".drop"
    }).disableSelection();
    $(".accordion").accordion();
}

function appendChild(parent, object) {
    let parentObject = $('#screen');
    if (parent != null) {
        parentObject = $("[children-container-for-id='" + parent + "']")
    }

    /*
    if(object.type == "UIContainer") {
        console.log("appendChild: " + JSON.stringify(parent) + " " + JSON.stringify(object));
    }
    */

    if (typeof object.template != "undefined") {
        let dialog = ejs.render(object.template, object);
        parentObject.append(dialog);
    }

    $(".dialog").draggable({handle: "> .title"});
    $(".drag").sortable({
        connectWith: ".drop"
    }).disableSelection();
    $(".accordion").accordion();
}


$(function () {
    let zIndex = 0;
    ue.game.callevent("OnUIFrameworkReady", "[]");

    $(document).on('keyup', function (event) {
        ue.game.callevent("OnUIFrameworkKeyPress", JSON.stringify([event.key.toUpperCase()]));
    });

    $('body').on("mousedown", function (e) {
        zIndex++;
        $(e.target).closest('.dialog').css({
            'z-index': zIndex
        });
    });


    $('body').on("click", ".button-close", function(e){
        let target = $(e.target);
        ue.game.callevent("OnUIFrameworkEvent", JSON.stringify([
            target.closest('.ui-framework-parent.dialog').attr('id'),
            "close-dialog",
            "none",
            ""
        ]));
    });

    $('body').on("click", function (e) {
        ue.game.callevent("OnUIFrameworkEvent", JSON.stringify([
            $(e.target).closest('.ui-framework-parent').attr('id'),
            "click"
        ]));
    });

    $('body').on("change", "select", function (e) {
        let target = $(e.target);
        let values = [];
        target.find("option:selected").each(function() {
            values.push($(this).attr('value'));
        });

        ue.game.callevent("OnUIFrameworkEvent", JSON.stringify([
            target.closest('.ui-framework-parent').attr('id'),
            "change",
            "array",
            JSON.stringify(values)
        ]));
    });

    $('body').on("change paste cut keyup", "input", function (e) {
        let target = $(e.target);

        if (target.attr('type') == "checkbox") {
            //checkbox
            let value = false;
            if (target.is(':checked')) {
                value = true;
            } else {
                value = false;
            }

            ue.game.callevent("OnUIFrameworkEvent", JSON.stringify([
                target.closest('.ui-framework-parent').attr('id'),
                "change",
                "bool",
                value
            ]));
        } else {
            //input
            let value = $(e.target).val();
            let oldValue = $(e.target).data('old-value');

            if (typeof oldValue == "undefined" || value != oldValue) {
                $(e.target).data('old-value', value);
                ue.game.callevent("OnUIFrameworkEvent", JSON.stringify([
                    $(e.target).closest('.ui-framework-parent').attr('id'),
                    "change",
                    "string",
                    value
                ]));
            }
        }
    });
});
