

$(function(){

    window.addEventListener("message", function(event){
        var showid = false
        if ( event.data.trans == true ) {
                $("#fotodiscord").attr("src", event.data.ava);
                $("#nombre").html(event.data.name);
                $(".formulario").fadeIn(1000);
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
            }, 100);
            if (showid == true) {
                $.post('https://Roda_ReportSystem/submit', JSON.stringify({
                    motivo: $("#motive").val(),   
                    info: $("#addinfo").val(),   
                    checkboxes: $(".checkboxes:checked").val(),
                    idshow: $("#idname").val(),
                })
                );
            }else if (showid == false) {
                $.post('https://Roda_ReportSystem/submit', JSON.stringify({
                    motivo: $("#motive").val(),   
                    info: $("#addinfo").val(),   
                    checkboxes: $(".checkboxes:checked").val(),
                })
                );
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
