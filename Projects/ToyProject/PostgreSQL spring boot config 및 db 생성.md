tasks
#toyProject
### tasks
- [x] postgreSQL user 생성 및 spring boot 연동 🛫 2023-12-02 📅 2023-12-02 ✅ 2023-12-02



~~~
## database  
spring.datasource.driver-class-name=org.postgresql.Driver  
spring.datasource.url=jdbc:postgresql://xxx.xxx.xxx.xxx:5432/playground  
spring.datasource.username=admin  
spring.datasource.password=*** 
  
## jpa  
spring.jpa.show-sql=true  
spring.jpa.hibernate.ddl-auto=create  
spring.jpa.properties.hibernate.format_sql=true  
spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true  
  
## logging  
logging.level.org.hibernate.sql=debug  
logging.level.org.hibernate.type.descriptor.sql.spi=trace
~~~


### 유저 생성
~~~
psql (14.10)
Type "help" for help.

yum_map_db=# CREATE USER jineun_park PASSWORD 'hjkas1541' SUPERUSER;
CREATE ROLE
~~~

