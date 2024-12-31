$(document).ready(function () {
    $("#sendMessageButton").click(function () {
        const message = $("#messageInput").val().trim();
        
        // AJAX 요청 전에 receiver 값 확인
        if (message && "<%= receiver %>") {
            $.ajax({
                url: "send_message.jsp",
                method: "POST",
                data: {
                    sender: "<%= username %>",
                    receiver: "<%= receiver %>",
                    message: message
                },
                success: function (response) {
                    $("#message-area").append(response);
                    $("#messageInput").val("");
                },
                error: function () {
                    alert("메시지 전송 실패");
                }
            });
        } else {
            alert("메시지 전송 중 receiver 확인이 필요합니다.");
        }
    });
});
