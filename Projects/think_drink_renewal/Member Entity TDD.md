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

**테**




### Trouble





### shooting
