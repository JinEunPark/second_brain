---
tags:
  - "#DP"
  - BFS
last updated: 
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> https://www.acmicpc.net/problem/2579




### background Information
[[BFS 메모리 초과]]


### Study




### Trouble

~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    public static class Node {  
        int st, sum, seq;  
  
        public Node(int st, int sum, int seq) {  
            this.st = st;  
            this.sum = sum;  
            this.seq = seq;  
        }  
    }  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        int n = Integer.parseInt(br.readLine());  
        int[] stares = new int[n + 1];  
        for (int i = 1; i < n+1; i++) {  
            stares[i] = Integer.parseInt(br.readLine());  
        }  
  
        Queue<Node> q = new LinkedList<>();  
        q.add(new Node(0, 0, 0));  
  
        List<Integer> result = new ArrayList<>();  
  
        while (!q.isEmpty()) {  
//            System.out.println(q.peek());  
  
            Node c = q.poll();  
  
            if (c.st == n) {  
                result.add(c.sum);  
                continue;            
                }  
  
            if (c.seq < 2 && c.st < n) {  
                q.add(new Node(c.st + 1, c.sum + stares[c.st + 1], c.seq + 1));//바로 앞계단  
                if (c.st < n - 1)  
                    q.add(new Node(c.st + 2, c.sum + stares[c.st + 2], 1));  
            } else {  
                if (c.st < n - 1)  
                    q.add(new Node(c.st + 2, c.sum + stares[c.st + 2], 1));  
            }  
  
        }  
  
        System.out.println(result.stream().max(Integer::compare).get());  
    }  
}
~~~


위의 코드로 총 최대 300 계단이 존재하는 문제에 대해서 완전 탐색을 했지만 메모리 초과가 발생했다.
그 이유는 2^300 * (int 3 개 =12) 개의 객체가 q 에 저장되었기 때문이다 간단하게 계산해봐도 말도안되는 풀이였다.


~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    public static class Node {  
        int st, sum, seq;  
        public Node(int st, int sum, int seq) {  
            this.st = st;  
            this.sum = sum;  
            this.seq = seq;  
        }  
    }  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        int n = Integer.parseInt(br.readLine());  
        int[] stares = new int[n + 1];  
        for (int i = 1; i < n+1; i++) {  
            stares[i] = Integer.parseInt(br.readLine());  
        }  
        int[] sums = new int[n+1];  
        Arrays.fill(sums, Integer.MIN_VALUE);  
  
        Queue<Node> q = new LinkedList<>();  
        q.add(new Node(0, 0, 0));  
  
        List<Integer> result = new ArrayList<>();  
  
        while (!q.isEmpty()) {  
//            System.out.println(q.peek());  
  
            Node c = q.poll();  
  
            if (c.seq < 2 && c.st < n) {  
                if(sums[c.st + 1] < c.sum + stares[c.st + 1]){  
                    sums[c.st + 1] = c.sum + stares[c.st + 1];  
                    q.add(new Node(c.st + 1, c.sum + stares[c.st + 1], c.seq + 1));//바로 앞계단  
                }  
                if (c.st < n - 1 && sums[c.st + 2] < c.sum + stares[c.st + 2]){  
                    sums[c.st + 2] = c.sum + stares[c.st + 2];  
                    q.add(new Node(c.st + 2, c.sum + stares[c.st + 2], 1));  
  
                }  
            } else {  
                if (c.st < n - 1 && sums[c.st + 1] < c.sum + stares[c.st + 1]){  
                    sums[c.st + 1] = c.sum + stares[c.st + 1];  
                    q.add(new Node(c.st + 2, c.sum + stares[c.st + 2], 1));  
  
                }  
            }  
  
        }  
  
        System.out.println(sums[n]);  
    }  
}
~~~


메모이 제이션을 적용해서 해당 칸의 크기가 전에 계산한것 보다 크지 않다면 진행시키지 않는 방법으로 큐에 삽입되는 경우의 수를 줄였다. 결과는 틀렸다....
내 상각에 이유는 현재 인덱스에 최댓값을 가지는 노드가 반드시 끝가지 최대값을 가진다는 보장이 없기 때문이다.




### shooting
~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        int n = Integer.parseInt(br.readLine());  
        int[] st = new int[n];  
        for (int i = 0; i < n; i++) {  
            st[i] = Integer.parseInt(br.readLine());  
        }  
        switch (n){  
            case 1:  
                System.out.println(st[0]);  
                return;            case 2:  
                System.out.println(st[0] + st[1]);  
                return;            case 3:  
                System.out.println(Math.max(st[0] + st[2], st[1] + st[2]));  
                return;        }  
        int[] dp = new int[n+1];  
        dp[0] = st[0];  
        dp[1] = Math.max(st[1] + st[0], st[1]);  
        dp[2] = Math.max(st[0] + st[2], st[1] + st[2]);  
        for (int i = 3; i < n; i++) {  
            dp[i] = Math.max(st[i] + st[i-1] + dp[i-3], st[i] + dp[i-2]);  
        }  
        System.out.println(dp[n-1]);  
    }  
}
~~~

정답 코드는 위와 같다. 

계단 오르는 데는 다음과 같은 규칙이 있다.

1. 계단은 한 번에 한 계단씩 또는 두 계단씩 오를 수 있다. 즉, 한 계단을 밟으면서 이어서 다음 계단이나, 다음 다음 계단으로 오를 수 있다.
2. 연속된 세 개의 계단을 모두 밟아서는 안 된다. 단, 시작점은 계단에 포함되지 않는다.
3. 마지막 도착 계단은 반드시 밟아야 한다.

위의 조건들을 만족 시키기 위해서 3개 연속으로 밟지 못한경우를 처리하기 위해서 노력했다. 위의 경우에는 
또한 도착 계단은 반드시 밟아야한다는 조건을 만족시키기 위해서 모든 i 번째 메모이 제이션에 해당 계단의 값이 포함되게 만들어야한다는 점에서 놀랐다. 나는 해당 칸에 해당 점수가 포함이 되지 않도라도 마지막 칸만 밟은 친구들을 필터링할 생각을 하고 있었는데 단단히 잘못되었다.

우선 점화식 도출과정을 이해해야한다. 왜냐면 나는 비슷한 문제는 무조건 맞을 생각이기 때문이다.

i = 1: st[0]
i = 2: st[0] + st[1]
i=3: st[0] + st[2], st[1] + st[2]
i=4: st[0] + st[1] + st[3], st[1] + st[3],  st[2] + st[3]
i=5:  
	x 0 0 x 0
	0 x 0 x 0
	 0 0 x x 0
	 0 0 x 0 0
	 x 0 x 0 0
	 x x x 0 0
위와 같은 경우의 수들이 나온다 이 때 한가지 규칙을 발경할 수 있는데 4 번의 경우의수 부터는 중복된 조합이 포함된다. 바로 하나 전의 수를 포함하는 경우와 그렇지 않은 경우를 나눌 수 있다. 
t[0] + st[1] + st[3], st[1] + st[3],  st[2] + st[3] 이 경우에 사실은 2 번까지 max 값은 0,1 을 모두 포함하는 것이다 따라서 첫번째 점화식인
dp[i] = st[i] + dp[i-2] 가 도출된다 그리고 5 번째를 보자
바로 직전의 수를 포함 시키는 경우에는 반드시 두번째 이후에 반드시 하나의 노드를 건너뛰고 계산하게된다 따라서 이를 하기 위해서는 dp[i] = st[i] + st[i-1] + dp[i-3] 이 된다. 이때 dp[i-3] 에서 -3 을 해준 이유는 이렇게 계산해야 연속해서 3개의 수를 더하는 경우를 막을 수 있기때문이다.


```java
package run;  
  
import java.io.*;  
import java.util.*;  
import java.util.stream.Collectors;  
  
class Main {  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        StringBuilder sb = new StringBuilder();  
  
        int n = Integer.parseInt(st.nextToken());  
        int[] stair = new int[n+4];  
  
        for (int i = 1; i <= n; i++) {  
            stair[i] = Integer.parseInt(br.readLine());  
        }  
        int[] dp = new int[n+4];  
  
        dp[0] = 0;  
        dp[1] = stair[1];  
        dp[2] = stair[1] + stair[2];  
        dp[3] = Math.max(stair[2] + stair[3], stair[1] + stair[3]);  
  
        for (int i = 4; i <= n; i++) {  
            dp[i] = Math.max(dp[i-2] + stair[i], dp[i-3] + stair[i-1] + stair[i]);  
        }  
  
        System.out.println(dp[n]);  
        return;    }  
}
```

위의 문제를 푸는데 가장 중요한 점은 연속 3 개의 계단을 밟지 않는 것이다.

```java
for (int i = 4; i <= n; i++) {  
		dp[i] = Math.max(dp[i-2] + stair[i], dp[i-3] + stair[i-1] + stair[i]);  

```

위의 점화 식에서 볼 수 있듯이 가장 중요한 점은 i 를 반드시 밟으면서 연속 3개가 되지 않는 계단을 구하는 것이다. 따라서 (i, i-2), (i, i-1, i-3) 이런 식으로 하면 
1. i, i-2 에서는 i -1 을 밟지 않고 
2. i, i-1, i -3 에서는 i-2 를 밟지 않아서 연속 3개를 밟는 것이 불가능하다.


