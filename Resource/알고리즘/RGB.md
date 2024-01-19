---
tags:
  - DP
last updated: 
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> https://www.acmicpc.net/problem/1149


### background Information
# RGB거리 성공

|시간 제한|메모리 제한|제출|정답|맞힌 사람|정답 비율|
|---|---|---|---|---|---|
|0.5 초 (추가 시간 없음)|128 MB|107932|59937|44692|54.767%|

## 문제

RGB거리에는 집이 N개 있다. 거리는 선분으로 나타낼 수 있고, 1번 집부터 N번 집이 순서대로 있다.

집은 빨강, 초록, 파랑 중 하나의 색으로 칠해야 한다. 각각의 집을 빨강, 초록, 파랑으로 칠하는 비용이 주어졌을 때, 아래 규칙을 만족하면서 모든 집을 칠하는 비용의 최솟값을 구해보자.

- 1번 집의 색은 2번 집의 색과 같지 않아야 한다.
- N번 집의 색은 N-1번 집의 색과 같지 않아야 한다.
- i(2 ≤ i ≤ N-1)번 집의 색은 i-1번, i+1번 집의 색과 같지 않아야 한다.

## 입력

첫째 줄에 집의 수 N(2 ≤ N ≤ 1,000)이 주어진다. 둘째 줄부터 N개의 줄에는 각 집을 빨강, 초록, 파랑으로 칠하는 비용이 1번 집부터 한 줄에 하나씩 주어진다. 집을 칠하는 비용은 1,000보다 작거나 같은 자연수이다.

## 출력

첫째 줄에 모든 집을 칠하는 비용의 최솟값을 출력한다.


### Study



~~~java

package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int n = Integer.parseInt(st.nextToken());  
  
        int[][] rgb = new int[n][3];  
        for (int i = 0; i < n; i++) {  
            st = new StringTokenizer(br.readLine());  
            int r = Integer.parseInt(st.nextToken());  
            int g = Integer.parseInt(st.nextToken());  
            int b = Integer.parseInt(st.nextToken());  
            rgb[i][0] = r;  
            rgb[i][1] = g;  
            rgb[i][2] = b;  
        }  
  
        int dp[][] = new int[n][3];  
        dp[0] = rgb[0];  
  
        for (int i = 1; i < n; i++) {  
            for (int j = 0; j < 3; j++) {  
                int cost = Integer.MAX_VALUE;  
                for (int k = 0; k < 3; k++) {  
                    if(k != j && dp[i-1][k] < cost){  
                        cost = dp[i-1][k];  
                    }  
                }  
                dp[i][j] = rgb[i][j] + cost;  
            }  
        }  
  
        System.out.println(Arrays.stream(dp[n-1]).min().getAsInt());  
    }  
}


~~~


정답은 간단하지만 생각보다 아이디어가 필요한 부분이다. 끌어당김의 힘으로 풀었다.
이 문제를 풀수 있는 핵심 아이디어는 메모이제이션을 현재 i 번째에서 하나만 하는 것이 아니라 나올 수 있는 모든 경우의 수를 전부 수행한다는 것이고, 해당 순번의 색갈이 반드시 포함되는 메모이제이션을 진행한다고 생각하면 편하다.

전의  i -1 에서 R G B 에 대한 모든 dp 가 있다면 현재 내가 R 을 골랐을 경우 i-1 G, B 의 비용 그리고 현재 집의 R 을 색칠하는 비용을 더해주면된다. 초기에는 정말 이아이디어가 떠오르지 않아서 다음 최적의 값을 만났을 때 전의 최적값들의 메모이 제이션을 변경해야하는줄 알았다. 제발 나는 내가 똑똑해졌으면 좋겠다.

메모이 제이션 배열의 모양을 그리면 다음과 같다

| [i/RGB] | [R] | [G] | [B] |
| ---- | ---- | ---- | ---- |
| 0 | 12 | 12 | 1 |
| 1 | 3 | 42 | 9 |
| 2 | 12 | 3 | 5 |
| 3 | 235 | 325 | 23 |
| 4 | 34 | 23 | 2 |
위와 같이 모든 집에 따라서 RGB의 최적값을 다 구한후에 마지막에 index n 일 때의 최솟값을 반환하면된다.

**점화식**
~~~
dp[i] = min(dp[i-1][0],dp[i-1][1],dp[i-1][2]) + rgb[i];
~~~
 너무 만족스럽군

복습코드

```java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
  
    public static void main(String[] args) throws IOException {  
  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
  
        int n = Integer.parseInt(st.nextToken());  
        int[][] rgb = new int[n][3];  
  
        for (int i = 0; i < n; i++) {  
            st = new StringTokenizer(br.readLine());  
            int r = Integer.parseInt(st.nextToken());  
            int g = Integer.parseInt(st.nextToken());  
            int b = Integer.parseInt(st.nextToken());  
            rgb[i][0] = r;  
            rgb[i][1] = g;  
            rgb[i][2] = b;  
        }  
  
        int[][] dp = new int[n][3];  
        dp[0][0] = rgb[0][0];  
        dp[0][1] = rgb[0][1];  
        dp[0][2] = rgb[0][2];  
  
        for (int i = 1; i < n; i++) {  
            for (int j = 0; j < 3; j++) {  
                int min = Integer.MAX_VALUE;  
                for (int k = 0; k < 3; k++) {  
                    if (j != k) {  
                        if (min > dp[i - 1][k] + rgb[i][j])  
                            min = dp[i - 1][k] + rgb[i][j];  
                    }  
                }  
                dp[i][j] = min;  
            }  
        }  
  
        System.out.println(Math.min(dp[n - 1][0], Math.min(dp[n - 1][1], dp[n - 1][2])));  
  
    }  
}
```
### Trouble





### shooting
