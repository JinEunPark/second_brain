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
> https://www.acmicpc.net/problem/15651


### background Information
|시간 제한|메모리 제한|제출|정답|맞힌 사람|정답 비율|
|---|---|---|---|---|---|
|1 초|512 MB|63974|42776|32140|67.070%|

## 문제

자연수 N과 M이 주어졌을 때, 아래 조건을 만족하는 길이가 M인 수열을 모두 구하는 프로그램을 작성하시오.

- 1부터 N까지 자연수 중에서 M개를 고른 수열
- 같은 수를 여러 번 골라도 된다.

## 입력

첫째 줄에 자연수 N과 M이 주어진다. (1 ≤ M ≤ N ≤ 7)

## 출력

한 줄에 하나씩 문제의 조건을 만족하는 수열을 출력한다. 중복되는 수열을 여러 번 출력하면 안되며, 각 수열은 공백으로 구분해서 출력해야 한다.

수열은 사전 순으로 증가하는 순서로 출력해야 한다.

## 예제 입력 1 복사

3 1

## 예제 출력 1 복사

1
2
3
### study
같은 수를 여러번 골라도 된다는 부분에서 중복 순열이므로 모든 조합을 구하는 재귀를 이용했다.

~~~
    public static void dfs(int index, int n, int m, List<Integer> list){  
        if(index == m){  
            StringBuilder sb = new StringBuilder();  
            list.stream().forEach(i -> sb.append(i + " "));  
            System.out.println(sb.toString());  
            return;        
        }  
  
        for (int i = 1; i <= n; i++) {  
            list.add(i);  
            dfs(index + 1, n,m,list);  
            list.remove(list.size()-1);  
        }  
    }  
~~~

벡드레킹을 이용했고 중복을 허용하는 것이기 때문에 현재 인덱스를 포함하는 리스트를 다음 재귀로 넘기고 이후에 현재 리스트에서 반환된 후 재귀 호출전 수를 재거했다.

### Trouble

~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    public static void dfs(int index, int n, int m, List<Integer> list){  
        if(index == m){  
            StringBuilder sb = new StringBuilder();  
            list.stream().forEach(i -> sb.append(i + " "));  
            System.out.println(sb.toString());  
            return;        
        }  
  
        for (int i = 1; i <= n; i++) {  
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
    }  
}

시간초과이다...
기본적으로 n 이 7 m 이 7 까지이다. 그러므로 나올 수 있는 경우의 수는 7^7 승 80만번 ... 리스트에 존재하는 정수를 모두 연산하는 과정이 7 ... 420 만번 시간초과가 왜 나지? 그 이유는 출력 횟수 때문에다 약 8 백만번의 출력을 하기 때문에 출력 횟수가 많으로 시간 초과가가 발생했다. 이를 해결하기 위해서는 총 2 가지를 생각해 볼 수 있다.

당연하게도 보통연산보다 출력이 시간이 더 오래 걸리기 때문에 한번에 출력하는 방법이 필요 대충생각해서 1000번 이상의 출력이 있다면 아래 두 방법 이용하기

1. bufferedwrider 를 이용해서 한번에 출력 
2. string builder 를 이용해서 한번에 출력
2번을 이용한 경우이다

~~~

### shooting

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
  
        for (int i = 1; i <= n; i++) {  
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

dfs 가 연산 횟수 때문인줄알고 bfs 로 변환한 코드이다.

package run;  
  
import org.w3c.dom.ls.LSOutput;  
  
import javax.print.DocFlavor;  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    public static class  Node {  
        int index;  
        String s;  
        public Node(int index, String s){  
            this.index = index;  
            this.s = s;  
        }  
    }  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int n = Integer.parseInt(st.nextToken());  
        int m = Integer.parseInt(st.nextToken());  
        StringBuilder sb = new StringBuilder();  
        Queue<Node> q = new LinkedList<>();  
        q.add(new Node(0,""));  
  
        while(!q.isEmpty()){  
            Node c = q.poll();  
            if(c.index == m){  
                sb.append(c.s + "\n");  
                continue;            }  
  
            for (int i = 1; i <= n; i++) {  
  
                if(c.index == 0){  
                    q.add(new Node(c.index + 1, c.s+i));  
                    continue;                }  
                q.add(new Node(c.index + 1, c.s + " "+i));  
            }  
        }  
        System.out.println(sb.toString());  
    }  
}

~~~