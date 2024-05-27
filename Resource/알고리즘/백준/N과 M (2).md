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
> https://www.acmicpc.net/problem/15650

### background Information
|시간 제한|메모리 제한|제출|정답|맞힌 사람|정답 비율|
|---|---|---|---|---|---|
|1 초|512 MB|71719|53527|38242|74.062%|

## 문제

자연수 N과 M이 주어졌을 때, 아래 조건을 만족하는 길이가 M인 수열을 모두 구하는 프로그램을 작성하시오.

- 1부터 N까지 자연수 중에서 중복 없이 M개를 고른 수열
- 고른 수열은 오름차순이어야 한다.

## 입력

첫째 줄에 자연수 N과 M이 주어진다. (1 ≤ M ≤ N ≤ 8)

## 출력

한 줄에 하나씩 문제의 조건을 만족하는 수열을 출력한다. 중복되는 수열을 여러 번 출력하면 안되며, 각 수열은 공백으로 구분해서 출력해야 한다.

수열은 사전 순으로 증가하는 순서로 출력해야 한다.


### Study

~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    static StringBuilder sb = new StringBuilder();  
    public static void dfs(int index, int n, int m, List<Integer> list){  
        if(index == m){  
            list.stream().forEach(i -> sb.append(i + " "));  
            sb.append("\n");  
            return;        }  
        int s = index == 0? 1:list.get(list.size()-1)+1;  
        for(int i = s; i <= n; i++) {  
            list.add(i);  
            dfs(index + 1, n,m,list);  
            list.remove(list.size()-1);  
        }  
    }  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int n = Integer.parseInt(st.nextToken());  
        int m = Integer.parseInt(st.nextToken());  
  
        dfs(0,n,m,new ArrayList<>());  
        System.out.println(sb);  
    }  
}
~~~

이 문제는 중복을 혀용하지 않아야 한다는 점이 특이점이다 따라서 이르 하기 위해서는 
~~~   
int s = index == 0? 1:list.get(list.size()-1)+1;  
        for(int i = s; i <= n; i++) {  
            list.add(i);  
            dfs(index + 1, n,m,list);  
            list.remove(list.size()-1);  
        }  
~~~

시작 인덱스를 바로 전에 선택한 인덱스의 다음 수로 설정하는 for 문을 만들었다.

### Trouble





### shooting
