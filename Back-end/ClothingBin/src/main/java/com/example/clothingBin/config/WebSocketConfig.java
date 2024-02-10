package com.example.clothingBin.config;

import com.example.clothingBin.utils.StompExceptionHandler;
import com.example.clothingBin.utils.StompHandler;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

//    private final WebSocketHandler webSocketHandler;

    private final StompHandler stompHandler;
    private final StompExceptionHandler stompExceptionHandler;

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        //해당 파라미터의 접두사가 붙은 목적지(구독자)에 메시지를 보낼
        registry.enableSimpleBroker("/sub");
        registry.setApplicationDestinationPrefixes("/pub");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        //엔드포인트 추가 등록
        registry
                .setErrorHandler(stompExceptionHandler)		//exception handler를 위한 것
                .addEndpoint("/websocket-endpoint")
                .addInterceptors()
                .setAllowedOriginPatterns("*");
    }

    //tcp handshake시 jwt 인증용 - 1회성
    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.interceptors(stompHandler);
    }
}