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
> https://www.acmicpc.net/problem/15654

### background Information

```java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
import java.util.stream.Collectors;  
  
public class Main {  
    static int m = 0;  
    static int n = 0;  
    static int[] arr = null;  
    static List<String> ans = new ArrayList<>();  
  
    public static void dfs(int dept, int[] tmp, boolean[] v){  
        if(dept == m){  
            StringBuilder sb = new StringBuilder();  
            for (int i = 0; i < m; i++) {  
                sb.append(tmp[i]).append(" ");  
            }  
            ans.add(sb.toString().trim());  
            return;        }  
  
        for (int i = 0; i < n; i++) {  
            if(v[i]) continue;  
            v[i] = true;  
            tmp[dept] = arr[i];  
            dfs(dept + 1,tmp , v);  
            v[i] = false;  
        }  
    }  
  
  
    public static void main(String[] args) throws IOException {  
  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
  
        n = Integer.parseInt(st.nextToken());  
        m = Integer.parseInt(st.nextToken());  
        arr = new int[n];  
  
        st = new StringTokenizer(br.readLine());  
        for (int i = 0; i < n; i++) {  
            arr[i] = Integer.parseInt(st.nextToken());  
        }  
        Arrays.sort(arr);  
  
        dfs(0,new int[m], new boolean[n]);  
  
        StringBuilder sb = new StringBuilder();  
        for(String i: ans) {  
            sb.append(i).append("\n");  
        }  
        System.out.println(sb);  
        return;    
	}  
}
```

### Study



### Trouble





### shooting
