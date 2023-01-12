package com.ma.crud.CompetitionsRest.websocket;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;

@Controller
public class CompetitionsWebSocketController {


    @MessageMapping("/competitions/add")
    public String greeting() throws Exception {
        return "dd";
    }
}
