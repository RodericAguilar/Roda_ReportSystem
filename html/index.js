$(function(){

    window.addEventListener("message", function(event){
        var showid = false
        
        if ( event.data.trans == true ) {
                $("#fotodiscord").attr("src", event.data.ava);
                $("#nombre").html(event.data.name);
                $(".formulario").fadeIn(1000);
                $( ".formulario" ).draggable();
            }

            if (event.data.img) {
                $("#screen").attr("src", event.data.img);
                $("#picture").fadeOut(0)
                $("#enviar").fadeIn(100)
            } else {
                $("#picture").fadeIn(0)
            }

        $('input:radio[name="remember_me"]').change(
            function(){
                if ($(this).is(':checked') && $(this).val() == 'Player Report') {
                    $(".showid").fadeIn(0);
                    showid = true
                }else{
                    $(".showid").fadeOut(0);
                    showid = false
                }
        });

        $("#picture").click(() => {
            setTimeout(() => {
                    $.post('https://Roda_ReportSystem/takepic', JSON.stringify({}));
            }, 100);
        });

        $("#screen").click(() => {
            $("#fullsize").attr("src", event.data.img);
            $("#fullsize-screenshot").fadeIn();
        });

        $(".closeicon").click(() => {
            $("#fullsize-screenshot").fadeOut();
        });
      
        $("#enviar").click(() => {
            var checkboxes = $('.checkboxes');
            checkboxes.change(function(){
                if($('.checkboxes:checked').length>0) {
                    checkboxes.removeAttr('required');
                } else {
                    checkboxes.attr('required', 'required');
                }
            });
            var motivo = document.getElementById("motive");
            var info = document.getElementById("addinfo");
            if($(motivo).val() === ''|| $(info).val() === '') {
                return
            }
            $(".formulario").fadeOut(1000);
            setTimeout(() => {
                    $.post('https://Roda_ReportSystem/exit', JSON.stringify({}));
            }, 0);
            if ($('#idname').val().length == 0) {

                $.post('https://Roda_ReportSystem/submit', JSON.stringify({
                    motivo: $("#motive").val(),   
                    info: $("#addinfo").val(),   
                    checkboxes: $(".checkboxes:checked").val(),
                    pic: event.data.img,
                })
                );
                return;
            }else  {
                $.post('https://Roda_ReportSystem/submit', JSON.stringify({
                    motivo: $("#motive").val(),   
                    info: $("#addinfo").val(),   
                    checkboxes: $(".checkboxes:checked").val(),
                    idshow: $("#idname").val(),
                    pic: event.data.img,
                })
                );
               return;
            }
        });

    })    
})






$(document).keyup((e) => {
    if (e.key === "Escape") {
        $(".formulario").fadeOut(1000);
        setTimeout(() => {
            $.post('https://Roda_ReportSystem/exit', JSON.stringify({}));
        
        }, 300);
    }
});