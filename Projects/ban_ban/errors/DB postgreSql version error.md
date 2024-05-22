post gre sql 연동시 verision 오류

```java
org.postgresql.util.PSQLException: The authentication type 825,306,675 is not supported. Check that you have configured the pg_hba.conf file to include the client's IP address or subnet, and that it is using an authentication scheme supported by the driver.
	at org.postgresql.core.v3.ConnectionFactoryImpl.doAuthentication(ConnectionFactoryImpl.java:614) ~[postgresql-42.1.4.jar:42.1.4]
	at org.postgresql.core.v3.ConnectionFactoryImpl.openConnectionImpl(ConnectionFactoryImpl.java:222) ~[postgresql-42.1.4.jar:42.1.4]
	at org.postgresql.core.ConnectionFactory.openConnection(ConnectionFactory.java:49) ~[postgresql-42.1.4.jar:42.1.4]
	at org.postgresql.jdbc.PgConnection.<init>(PgConnection.java:194) ~[postgresql-42.1.4.jar:42.1.4]

```