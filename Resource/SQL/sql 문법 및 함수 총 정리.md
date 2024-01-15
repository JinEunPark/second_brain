
### if(조건문, 참일때 적용값, 거짓일 때 적용값)

```sql
select 
	warehouse_id, 
	warehouse_name, 
	address, 
	if(isnull(freezer_yn) = true, "N", freezer_yn) as freezer_yn
```
