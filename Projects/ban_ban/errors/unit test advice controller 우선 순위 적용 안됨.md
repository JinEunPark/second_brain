### 선언한 BusinessLogicController 가 높은 우선순위로 적용되지 않는 문제가 있었음


```java
package com.example.ban_ban_taxi.exception_handler;  
  
import com.example.ban_ban_taxi.com.api.Api;  
import com.example.ban_ban_taxi.com.exception.BusinessLogicException;  
import lombok.extern.slf4j.Slf4j;  
import org.apache.coyote.Response;  
import org.springframework.core.annotation.Order;  
import org.springframework.http.ResponseEntity;  
import org.springframework.web.bind.annotation.ExceptionHandler;  
import org.springframework.web.bind.annotation.RestControllerAdvice;  
  
@RestControllerAdvice  
@Order(value = Integer.MIN_VALUE) // 최우선 처리  
@Slf4j  
public class BusinessExceptionHandler {  
  
    @ExceptionHandler(value = BusinessLogicException.class)  
    public ResponseEntity<Object> businessException(  
            BusinessLogicException exception  
    ){  
        log.error("",exception.getExceptionCode());  
        var errorCode = exception.getErrorCodeIfs();  
        return ResponseEntity  
                .status(errorCode.getErrorCode())  
                .body(  
                        Api.ERROR(errorCode, exception.getErrorDescription())  
                );  
    }  
}
```

- @order annotation 을 이용해서 우선순위를 최소로 줬는데도 적용되지 않는 문제가 있었음
이를 해결하기 위해서는 모든 컨트롤러가 아닌 현재 컨트롤러의 컨텍스트만 로드해야했음


```java
package com.example.ban_ban_taxi.exception_handler;  
  
import com.example.ban_ban_taxi.com.error.ErrorCode;  
import com.example.ban_ban_taxi.com.exception.BusinessLogicException;  
import com.example.ban_ban_taxi.member.controller.impl.MemberControllerImpl;  
import com.example.ban_ban_taxi.member.dto.MemberIdDto;  
import com.example.ban_ban_taxi.member.dto.MemberPostDto;  
import com.example.ban_ban_taxi.member.dto.MemberResponseDto;  
import com.example.ban_ban_taxi.member.service.impl.MemberServiceImpl;  
import com.fasterxml.jackson.databind.ObjectMapper;  
import org.junit.jupiter.api.BeforeEach;  
import org.junit.jupiter.api.Test;  
import org.junit.jupiter.api.extension.ExtendWith;  
import org.mockito.Mock;  
import org.mockito.junit.jupiter.MockitoExtension;  
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;  
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;  
import org.springframework.boot.test.mock.mockito.MockBean;  
import org.springframework.http.MediaType;  
import org.springframework.test.web.servlet.MockMvc;  
import org.springframework.test.web.servlet.setup.MockMvcBuilders;  
  
import java.util.UUID;  
  
import static org.junit.jupiter.api.Assertions.*;  
import static org.mockito.ArgumentMatchers.any;  
import static org.mockito.Mockito.verify;  
import static org.mockito.Mockito.when;  
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;  
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;  
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;  
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;  
  
@WebMvcTest(controllers = BusinessExceptionHandler.class)  
@AutoConfigureMockMvc(addFilters = false)//필터 제외하고 test  
class BusinessExceptionHandlerTest {  
  
  
    @MockBean  
    private MemberServiceImpl memberService;  
    private MockMvc mockMvc;  
  
    private final String URI = "/api/member";  
  
    @BeforeEach  
    public void setUp(){  
        this.mockMvc = MockMvcBuilders  
                .standaloneSetup(new MemberControllerImpl(memberService))  
                .setControllerAdvice(BusinessExceptionHandler.class)  
                .build();  
    }  
  
  
    @Test  
    void businessException() throws Exception {  
        Long readMemberId = 1L;  
  
        MemberResponseDto memberResponseDto = MemberResponseDto.builder()  
                .email("wlsdms@")  
                .id(1L)  
                .name("wlsdms")  
                .build();  
  
        when(memberService.retrieveMemberById(any(Long.class)))  
                .thenThrow(new BusinessLogicException(ErrorCode.USER_NOT_FOUND));  
  
        mockMvc.perform(get(URI + "/read")  
                        .param("memberId", readMemberId.toString()))  
                .andExpect(status().isBadRequest())  
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))  
                .andReturn();  
  
    }  
}

```


위의 테스트 코드에서 
```java
    @BeforeEach  
    public void setUp(){  
        this.mockMvc = MockMvcBuilders  
                .standaloneSetup(new MemberControllerImpl(memberService))  
                .setControllerAdvice(BusinessExceptionHandler.class)  
                .build();  
    }  
  

```

해당 함수를 통해서 controlleradvice 를 설정할 수 있었음
