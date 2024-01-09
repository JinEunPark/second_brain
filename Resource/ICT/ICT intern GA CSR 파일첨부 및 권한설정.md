- 2023/11/29



- [x] dtPlnGACSReqReg.html 에 저장, 수정(임시저장), 요청될 때 일단은 cpltSultData 로 완료 협의일 파라미터로 넘길 수 있게 변경할것
- [x] data base 에 완료 협의일 컬럼 추가
- [x] mapper 변경

### 상황
1. 완료협의일 cpltSultDate 추가함
```sql
ALTER TABLE your_table_name ADD COLUMN cplt_sult_date DATETIME NULL COMMENT 'comment 완료협의일';


ALTER TABLE your_table_name ADD COLUMN cplt_sult_date DATETIME NULL COMMENT 'comment 완료협의일';

```

![[스크린샷 2023-11-30 오후 3.28.39.png]]
### 이슈
1. java.sql.timestamp 의 parameter 가 Strng type 의 날짜에 mapping 이 되지 않는 문제 springboot 내부에서 받은 후에 date format 으로 변경하는 로직을 수행함.