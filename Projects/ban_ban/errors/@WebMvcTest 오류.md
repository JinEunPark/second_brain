```java
@WebMvcTest(controllers = MemberControllerImpl.class)  
@AutoConfigureMockMvc(addFilters = false)//필터 제외하고 test@ExtendWith(MockitoExtension.class)  
class MemberControllerImplTest {  
    @Autowired  
    private MockMvc mockMvc;  
    @Mock  
    private MemberServiceImpl memberService;  
  
    @Autowired  
    private ObjectMapper objectMapper;  
  
    @Test  
    void createMember() throws Exception {  
        // given  
        MemberPostDto memberPostDto = MemberPostDto.builder()  
                .email(UUID.randomUUID().toString() + "@gmail.com")  
                .name("wlsdsm")  
                .password(UUID.randomUUID().toString())  
                .build();  
  
        MemberIdDto memberIdDto = new MemberIdDto(1L);  
  
        when(memberService.saveMember(any(MemberPostDto.class))).thenReturn(memberIdDto);  
  
        // when & then  
        mockMvc.perform(  
                        post("/member")  
                                .contentType(MediaType.APPLICATION_JSON)  
                                .content(new ObjectMapper().writeValueAsString(memberPostDto)))  
                .andExpect(status().isCreated());  
  
        verify(memberService).saveMember(any(MemberPostDto.class));  
    }
```

위의 테스트 코드를 작성하던 도중 에러가 발생했다.

```java
Caused by: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'memberControllerImpl' defined in file [/Users/bagjin-eun/Desktop/javaProject/ban_ban_taxi/build/classes/java/main/com/example/ban_ban_taxi/member/controller/impl/MemberControllerImpl.class]: Unsatisfied dependency expressed through constructor parameter 0: No qualifying bean of type 'com.example.ban_ban_taxi.member.service.MemberService' available: expected at least 1 bean which qualifies as autowire candidate. Dependency annotations: {}
	at app//org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:795)
	at app//org.springframework.beans.factory.support.ConstructorResolver.autowireConstructor(ConstructorResolver.java:237)
	at app//org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireConstructor(AbstractAutowireCapableBeanFactory.java:1355)
	at app//org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1192)
	at app//org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562)
	at app//org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522)
	at app//org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:326)
	at app//org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234)
	at app//org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:324)
	at app//org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:200)
	at app//org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:975)
	at app//org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:962)
	at app//org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:624)
	at app//org.springframework.boot.SpringApplication.refresh(SpringApplication.java:754)
	at app//org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:456)
	at app//org.springframework.boot.SpringApplication.run(SpringApplication.java:334)
	at app//org.springframework.boot.test.context.SpringBootContextLoader.lambda$loadContext$3(SpringBootContextLoader.java:137)
	at app//org.springframework.util.function.ThrowingSupplier.get(ThrowingSupplier.java:58)
	at app//org.springframework.util.function.ThrowingSupplier.get(ThrowingSupplier.java:46)
	at app//org.springframework.boot.SpringApplication.withHook(SpringApplication.java:1454)
	at app//org.springframework.boot.test.context.SpringBootContextLoader$ContextLoaderHook.run(SpringBootContextLoader.java:553)
	at app//org.springframework.boot.test.context.SpringBootContextLoader.loadContext(SpringBootContextLoader.java:137)
	at app//org.springframework.boot.test.context.SpringBootContextLoader.loadContext(SpringBootContextLoader.java:108)
	at app//org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContextInternal(DefaultCacheAwareContextLoaderDelegate.java:225)
	at app//org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContext(DefaultCacheAwareContextLoaderDelegate.java:152)
	... 86 more

```


위의 로그에서 알 수 있는 점은 bean 이 생성이 안됐다는 것 무슨 말이냐
memberService 가 등록이 안됐다는 것, mockito 를 사용하는데?? 라고 의문이 들었다. 

```java
@WebMvcTest(controllers = MemberControllerImpl.class)  
@AutoConfigureMockMvc(addFilters = false)//필터 제외하고 @ExtendWith(MockitoExtension.class)
```


위의 에노테이션에서 
1. @WebMvcTest(controllers = MemberControllerImpl.class)  은 실제로 controller 와 연관된 application context 는 로드한다 즉 spring container 에 의해서 실행된다는 것 
2. 필자는 @Mock 에노테이션을 이용해서 Mock 을 등록했다고 생각했다 하지만 이 방법은 spring container 에 bean 으로 등록되는 방법이 아니기 때문에 당연하게 오류가 발생한다.
3. 따라서 이를 해결하기 위해서는 
```
@MockBean  
private MemberServiceImpl memberService;
```

위처럼 Mock Bean 에노테이션을 사용해서 내가 만든 목 객체를 스프링 컨텍스트에 올려서 나중에 WebMvcTest 에서 controller 에 대한 context 를 로드할 때 붙여줄꺼야 라는 과정이 필요하다. 해결 완료
