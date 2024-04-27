---
tags: 
last updated: 
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> Contents

### background Information

```java
package com.example.think_drink2.member.model;  
  
import com.example.think_drink2.member.model.state.Active;  
import com.example.think_drink2.member.model.state.Gender;  
import jakarta.persistence.*;  
import jakarta.validation.constraints.Email;  
import jakarta.validation.constraints.Size;  
import lombok.*;  
  
@NoArgsConstructor  
@Entity  
@Table  
@Data  
@Getter  
@Builder  
@AllArgsConstructor  
  
public class Member {  
    @Id  
    @GeneratedValue(strategy = GenerationType.IDENTITY)  
    private Long id;  
  
    @Column(nullable = false)  
    @Email(message = "please input the format of email")  
    private String email;  
  
    @Column(nullable = false)  
    @Size(min = 4, max = 50)  
    private String password;  
  
    @Embedded  
    private HealthInfo healthInfo;  
  
    public void setHeathInfo(HealthInfo healthInfo){  
        this.healthInfo = healthInfo;  
    }  
}
```

```java
@RequiredArgsConstructor  
public enum Active {  
    HYPERACTIVE("HYPERACTIVE"),  
    ACTIVE("ACTIVE"),  
    MID("MID"),  
    LOW("LOW");  
  
    private final String active;  
}

@RequiredArgsConstructor  
public enum Gender {  
    MAN("MAN"),  
    WOMAN("WOMAN");  
    private final String gender;  
  
}
```

```java
package com.example.think_drink2.member.model;  
  
import com.example.think_drink2.member.model.state.Active;  
import com.example.think_drink2.member.model.state.Gender;  
import jakarta.persistence.Embeddable;  
import jakarta.persistence.Enumerated;  
  
@Embeddable  
public class HealthInfo {  
    @Enumerated  
    private Gender gender;  
  
    @Enumerated  
    private Active active;  
  
    private Double weight;  
  
    private Double height;  
}

```

건강 정보는 따로 임베디드 타입으로 선언함

### Study

TDD 기반의 개발을 도입하기 위해서 테스트 코드를 먼저 작성 후 이를 커버하는 방식으로 진행했다.

**테스트 코드 작성과 구현**
TDD 개발의 핵심은 테스트 코드를 작성 후 개발을 진행하는 것이다. 이를 위해서 간단한 테스트 코드를 작성해보겠다.


```java
@DataJpaTest  
class MemberRepositoryTest {  
      
    @Autowired  
    private MemberRepository memberRepository;  
    @Test  
    public void MemberRepositoryNullTest(){  
        assertThat(memberRepository).isNotNull();  
    }  
  
}
```

가장 먼저 작성한 테스트 코드는 빈 주입의 유무를 확인하는 코드이다. 초기에 memberRepository 를 작성하기 전에는 당연하게도 오류가 발생한다. 
```java
@ExtendWith(SpringExtension.class)
@OverrideAutoConfiguration(enabled = false)
@TypeExcludeFilters(DataJpaTypeExcludeFilter.class)
@Transactional
@AutoConfigureCache
@AutoConfigureDataJpa
@AutoConfigureTestDatabase
@AutoConfigureTestEntityManager
@ImportAutoConfiguration

출처: [https://mangkyu.tistory.com/184](https://mangkyu.tistory.com/184) [MangKyu's Diary:티스토리]
```

위의 에노테이션들은 모두 springdatajpa 에 속해있는 에노테이션들이다. 위에서 볼 수 있듯이 @Transactional 을 포함하고 있기 때문에 이에 대해서 따로 추가할 필요가 없다. 따라서 롤벡 또한 걱정하지 않아도 된다.


이제 해당 테스트를 만족하기 위해서 실제로 레포를 구현해보자
```java
public interface MemberRepository extends JpaRepository<Member, Long> {  
    Member findMemberById(final Long id);  
}
```


이후 실행하면 테스트를 통과할 것인가 당연히 아니다 왜냐하면 기본적으로 DataJpaTest 는 @AutoConfigureTestDatabase 를 통해서 임베디드 데이터 베이스를 로드하지만 나는 해당 프로젝트에서 엠베디드 DB 를 설정한 적이 없어서 이를 정상적으로 실행할 수 없는 것 이를 






### Trouble





### shooting
