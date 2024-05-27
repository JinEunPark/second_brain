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


|시간 제한|메모리 제한|제출|정답|맞힌 사람|정답 비율|
|---|---|---|---|---|---|
|0.1 초 ([하단 참고](https://www.acmicpc.net/problem/9251#))|256 MB|87801|36327|26588|40.764%|

## 문제

LCS(Longest Common Subsequence, 최장 공통 부분 수열)문제는 두 수열이 주어졌을 때, 모두의 부분 수열이 되는 수열 중 가장 긴 것을 찾는 문제이다.

예를 들어, ACAYKP와 CAPCAK의 LCS는 ACAK가 된다.

## 입력

첫째 줄과 둘째 줄에 두 문자열이 주어진다. 문자열은 알파벳 대문자로만 이루어져 있으며, 최대 1000글자로 이루어져 있다.

## 출력

첫째 줄에 입력으로 주어진 두 문자열의 LCS의 길이를 출력한다.
### Study
해당 문제는 알면 쉽게 풀수 있는 반면 모르면 풀기가 조금 어렵다. 원리는 쉽게 다음과 같다.
a b c d 
a c d b 
위와 같은 문자열이 두개 존잰한다고 가정하자 다이나믹 프로그래밍은 최소 큰 문제를 작은 문제로 최소화 하여 풀이하는 방식이다. 따라서 두문자열의 최대 부분 수열을 작게 나누어서 작은 부분으로 나누어 보자. 
만일 끝의 문자가 다르다고 가정하면 마지막 문자를 제외한 문자로 나눌 수 있다. 

a b c d
a c d 

a b c 
a c d b 

위와 같이 문자 하나 전의 문자열의 부분 문제로 나눌 수 있다. 

더 작게 쪼개보자 
a b
a
최소단위로 쪼개면 다음과 같다. 

그러면 첫번째 문자에서 바로 공통 부분 수열일 것을 알 수 있다. 그렇다면 ab a 의 LCS 는 1 이다.
다음 abc a 의 LCS 는? 1 이다.

ab, a 의 LCS 에 c 와 a 의 비교를 더한 것이기 때문이다. 따라서 이를 설명해면 다음과 같다.

그렇다면 현재 문자가 같을 때와 다를 때를 생각해보자.

현재 인덱스의 문자가 같을 때는
a b c
a c
두끝이 c 로 같다고 가정하면 이는 ab 와 a 의 LCS +1 을 한 값과 같다 따라서 점화식은 

```

dp[i-1][j-1] + 1

```

그렇다면 다를 때는??

a b c d 
a c d b 

위의 두 문자열에서 끝의 두 문자가 다른 것을 볼 수 있다.
이는 abc, acbd 의 값, acd, abcd 의 값 둘중에 하나라고 볼 수 있다. 그렇다면 무엇을 골라야할까? 더 큰거다.

```
dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
```

|     |     | a   | b   | c   | d   |
| --- | --- | --- | --- | --- | --- |
|     | 0   | 0   | 0   | 0   | 0   |
| a   | 0   | 1   | 1   | 1   | 1   |
| c   | 0   | 1   | 1   |     |     |
| d   | 0   |     |     |     |     |
| b   | 0   |     |     |     |     |



```java
import java.io.*;
import java.util.*;

class Main {

    public static void main(String[] args) throws IOException {

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();

        String[] a = br.readLine().split("");
        String[] ta = new String[a.length + 1];
        ta[0] = " ";
        for (int i = 1; i < a.length + 1; i++) {
            ta[i] = a[i-1];
        }

        String[] b = br.readLine().split("");
        String[] tb = new String[b.length + 1];
        for (int i = 1; i < b.length + 1; i++) {
            tb[i] = b[i-1];
        }

        int[][] dp = new int[a.length + 1][b.length + 1];

        for (int i = 1; i < a.length + 1; i++){
            for (int j = 1; j < b.length + 1; j++) {
                String x = ta[i];
                String y = tb[j];
                if(x.equals(y)){
                    dp[i][j] = dp[i-1][j-1] + 1;
                }else{
                    dp[i][j] = Math.max(dp[i-1][j],dp[i][j-1]);
                }
            }
        }

        System.out.println(dp[a.length][b.length]);
        return;
    }
}




```


### Trouble





### shooting
