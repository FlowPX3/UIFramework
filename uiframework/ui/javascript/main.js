let zIndex = 0;

function setVisibility(object, visibility) {
    if (visibility) {
        let obj = $("#" + object.id);
        obj.show();

        //set the newest dialog to front
        if(object.type == "UIDialog") {
            zIndex++;
            obj.css({
                'z-index': zIndex
            });

            $('.dialog').removeClass('active');
            obj.addClass('active');
        }
    } else {
        $("#" + object.id).hide();
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


function refreshEventsAndFunctions() {
    
    let colorPickers = $('.ui-color-picker input');
    for(var i = 0; i < colorPickers.length; i++) {

        if(typeof $(colorPickers[i]).data('loaded') == "undefined") {
            $(colorPickers[i]).data('loaded', true)

            let colorPicker = colorPickers[i];
            picker = new CP(colorPicker);

            // prevent showing native color picker panel
            colorPicker.onclick = function(e) {
                e.preventDefault();
            };

            picker.on("change", function(color) {
                this.source.value = '#' + color;
                let target = $(this.source);
                ue.game.callevent("OnUIFrameworkEvent", JSON.stringify([
                    target.closest('.ui-framework-parent').attr('id'),
                    "change",
                    "string",
                    '#' + color
                ]));
            });
        }
    }

    $(".dialog").draggable({handle: "> .title"});
    $(".drag").sortable({
        connectWith: ".drop"
    }).disableSelection();
    $(".accordion").accordion();
}

function updateObject(object) {
    $('#' + object.id).remove();

    //console.log(JSON.stringify(object));

    let parentObject = $("[children-container-for-id='" + object.parent + "']")

    if (typeof object.template != "undefined") {
        let obj = $(ejs.render(object.template, object));
        parentObject.append(obj);

        //set the newest dialog to front
        if(object.type == "UIDialog") {
            zIndex++;
            obj.css({
                'z-index': zIndex
            });
            $('.dialog').removeClass('active');
            obj.addClass('active');
        }
    }

    refreshEventsAndFunctions();
}


$(function () {
    //console.log("load")
    
    ue.game.callevent("OnUIFrameworkReady", "[]");

    $(document).on('keyup', function (event) {
        ue.game.callevent("OnUIFrameworkKeyPress", JSON.stringify([event.key.toUpperCase()]));
    });

    $('body').on("sortstop", function( event, ui ) {
        console.log(JSON.stringify(ui))
    });

    $('body').on("mousedown", function (e) {
        zIndex++;
        $(e.target).closest('.dialog').css({
            'z-index': zIndex
        });

        $('.dialog').removeClass('active');
        $(e.target).closest('.dialog').addClass('active');

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
