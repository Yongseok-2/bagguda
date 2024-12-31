package termpackage;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;

@ServerEndpoint("/asd/chat/{owner}")
public class ChatWebSocketHandler {

    @OnOpen
    public void onOpen(Session session, @PathParam("owner") String owner) {
        System.out.println(owner + " 연결됨");
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("받은 메시지: " + message);
        try {
            session.getBasicRemote().sendText("Echo: " + message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("연결 종료");
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("WebSocket 에러: " + throwable.getMessage());
    }
}
