---
tags:
  - 조합
  - DP
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
|시간 제한|메모리 제한|제출|정답|맞힌 사람|정답 비율|
|---|---|---|---|---|---|
|1 초|512 MB|101077|64357|41398|62.731%|

## 문제

자연수 N과 M이 주어졌을 때, 아래 조건을 만족하는 길이가 M인 수열을 모두 구하는 프로그램을 작성하시오.

- 1부터 N까지 자연수 중에서 중복 없이 M개를 고른 수열

## 입력

첫째 줄에 자연수 N과 M이 주어진다. (1 ≤ M ≤ N ≤ 8)

## 출력

한 줄에 하나씩 문제의 조건을 만족하는 수열을 출력한다. 중복되는 수열을 여러 번 출력하면 안되며, 각 수열은 공백으로 구분해서 출력해야 한다.

수열은 사전 순으로 증가하는 순서로 출력해야 한다.

## 예제 입력 1 복사

3 1

## 예제 출력 1 복사

1
2
3
## 예제 입력 2 복사

4 2

## 예제 출력 2 복사

1 2
1 3
1 4
2 1
2 3
2 4
3 1
3 2
3 4
4 1
4 2
4 3


### Study

사실 위 문제는 그렇게 어렵진 않았지만 시간 복잡도를 줄여복 싶어서 고민을 많이 했었다.
~~~java
자바 순열 이건 저장해줬다가 코테에 나오면 그대로 쓰자

package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    public static void dfs
    (int dept, int n, int num, int endDept, boolean[] visited, String print){  
        if(dept == endDept){  
            System.out.println(print);  
        }  
  
        for (int i = 1; i < n+1; i++) {  
            if(!visited[i]){  
                visited[i] = true;  
                if(dept != 0)  
                dfs(dept + 1, n, i, endDept,visited, print + " "+ i);  
                if(dept == 0)  
                    dfs(dept + 1, n, i, endDept,visited, ""+ i);  
                visited[i] = false;  
            }  
        }  
    }  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int n = Integer.parseInt(st.nextToken());  
        int k = Integer.parseInt(st.nextToken());  
        dfs(0,n,0,k, new boolean[n+1], "");  
  
    }  
}
~~~

기본 적으로 벡트레킹을 이용해서 순열을 구했다. 

~~~
   if(!visited[i]){  
                visited[i] = true;  
                if(dept != 0)  
                dfs(dept + 1, n, i, endDept,visited, print + " "+ i);  
                if(dept == 0)  
                    dfs(dept + 1, n, i, endDept,visited, ""+ i);  
                visited[i] = false;  
            }  
~~~

현재 방문한 숫자가 방문했던 숫자가 아니라면 출력하고 다음 수를 호출한다. 이후 해당 함수가 반환되면 현재 방문한 표시를 다시 초기화 시켜 다음 재귀에서 방문할 수 있도록 만들면된다.

문제의 조건에서 하나의 수열에 중복되는 수를 고르는 것을 허용하지  않았기 때문에 위와 같이 구현했다.


### Trouble
만일 위의 문제가 순열이 아니라 조합이었다면 어떻게 풀어야하나 생각했다.

~~~java
import java.util.ArrayList;
import java.util.List;

public class Combinations {

    public static List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> current = new ArrayList<>();
        combineHelper(n, k, 1, current, result);
        return result;
    }

    private static void combineHelper
    (int n, int k, int start, List<Integer> current, List<List<Integer>> result) {
        if (k == 0) {
            result.add(new ArrayList<>(current));
            return;
        }

        for (int i = start; i <= n; i++) {
            current.add(i);
            combineHelper(n, k - 1, i + 1, current, result);
            current.remove(current.size() - 1);
        }
    }

    public static void main(String[] args) {
        int n = 5;
        int k = 3;
        List<List<Integer>> combinations = combine(n, k);

        System.out.println("Combinations of " + n + " choose " + k + ":");
        for (List<Integer> combination : combinations) {
            System.out.println(combination);
        }
    }
}

~~~

사실 저번에 카카오 문제에서 조합을 구하지 못하고 망했던 적이 있어서 이렇게 메모해둔다.
### shooting
