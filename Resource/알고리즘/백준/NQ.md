---
tags:
  - DFS
last updated: 
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> https://www.acmicpc.net/problem/9663

### background Information
# N-Queen 성공

|시간 제한|메모리 제한|제출|정답|맞힌 사람|정답 비율|
|---|---|---|---|---|---|
|10 초|128 MB|106291|50921|33042|46.501%|

## 문제

N-Queen 문제는 크기가 N × N인 체스판 위에 퀸 N개를 서로 공격할 수 없게 놓는 문제이다.

N이 주어졌을 때, 퀸을 놓는 방법의 수를 구하는 프로그램을 작성하시오.

## 입력

첫째 줄에 N이 주어진다. (1 ≤ N < 15)

## 출력

첫째 줄에 퀸 N개를 서로 공격할 수 없게 놓는 경우의 수를 출력한다.

## 예제 입력 

8

## 예제 출력 

92


### Trouble

https://wikidocs.net/206359
사실 이문제는 너무 어려워서 위의 참고 문헌을 봤다 꼭 확인바람.

~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
  
    public static int answer = 0;  
    static int[] dx = {1, -1, 1, -1};  
    static int[] dy = {-1, 1, 1, -1};  
  
    private static void visited(int[][] board, int x, int y) {  
        Arrays.fill(board[x], 1);//가로  
        for (int i = 0; i < board.length; i++) {  
            board[i][y] = 1;  
        }  
        int tx = x;  
        int ty = y;  
        while (tx >= 0 && ty >= 0) {  
            board[tx][ty] = 1;  
            tx--;  
            ty--;  
        }  
        tx = x;  
        tx = x;  
        ty = y;  
  
        while (ty < board.length && tx < board.length) {  
            board[tx][ty] = 1;  
            tx++;  
            ty++;  
        }  
  
        tx = x;  
        ty = y;  
  
        while (0 <= tx && ty < board.length) {  
            board[tx][ty] = 1;  
            tx--;  
            ty++;  
        }  
  
        tx = x;  
        ty = y;  
  
        while (0 <= ty && tx < board.length) {  
            board[tx][ty] = 1;  
            tx++;  
            ty--;  
        }  
  
        return;  
    }  
  
    public static long dfs(int[][] board, int x) {  
  
        if (board.length == x) {  
            return 1;  
        }  
        long answer = 0;  
        for (int i = 0; i < board.length; i++) {  
            if (board[x][i] != 1) {  
                int[][] tmp = new int[board.length][board.length];  
                for (int j = 0; j < board.length; j++) {  
                    tmp[j] = board[j].clone();  
                }  
                visited(tmp, x, i);  
                answer += dfs(tmp, x + 1);  
            }  
        }  
        return answer;  
    }  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int n = Integer.parseInt(st.nextToken());  
        int[][] board = new int[n][n];  
  
        System.out.println(dfs(board, 0));  
  
    }  
}
~~~




공간 복잡도의 초과다 그 이유는 방문한 배열을 다시 사용하는 것이 아니라 clone 으로 깊은 복사를 실시해서 계산하기 때문에 n = 15 만 되어도 15^15*4 바이트가 필요하게 된다 따라서 이는 맞는 방법은 아니다.
위의 방법으로 문제를 풀었는데 일단 구현부터가 너무 어려운 방식으로 접근했다.


일단 위의 처럼 문제를 푼 과정은 dfs 를 적용해서 모든 경우에 체스처럼 현재 모든 판안에서 죽지않는 경우를 골라서 체스말을 추가하고 board 라는 이차원 배열을 생성해서 해당 배열에 체스말이 놓이면 팔방으로 모든 방문처리하기 위해서 이차원 배열을 1로 초기화 했다.

하지만 이 방법 아주 좋지 않은 선택이었다.


### shooting



~~~java

package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
  
    public static int answer = 0;  
  
    private static boolean check(int x, int[] board) {  
        for (int i = 0; i < x; i++) {  
            //같은 열에 다른 퀸이 존재할 경우  
            if(board[i] == board[x]){  
                return false;  
            }  
  
            //같은 대각선 상에 존재할 때  
            if(Math.abs(x - i) == Math.abs(board[x] - board[i])){  
                return false;  
            }  
  
        }  
        return true;  
    }  
  
    public static long dfs(int[] board, int x) {  
  
        if (board.length == x) {  
            return 1;  
        }  
        long answer = 0;  
        for (int i = 0; i < board.length; i++) {  
            board[x] = i;//해당 칸에 퀀을 놓음  
            if (check(x,board)) {  
                answer += dfs(board, x+1);//다음행으로 진행  
            }  
        }  
        return answer;  
    }  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int n = Integer.parseInt(st.nextToken());  
        int[] board = new int[n];  
        System.out.println(dfs(board, 0));  
  
    }  
}
~~~

위의 코드는 일단 dfs 를 행단위로 적용시켰다 왜냐하면 queen 은 팔방으로 움직이기 때문에 하나의 행에는 반드시 하나의 퀀이 존재해야하기 때문이다.

~~~
    public static long dfs(int[] board, int x) {  
~~~


따라서 오로지 행의 인덱스 만으로 dfs 를 구현할 수 있었다.
그리고 여기서 중요한점은 board 가 더이상 이차원 배열이 아니다. 그 이유는 일차원 배열의 인덱스를 행의 수로 잡고 값을 열로 잡는 다면 위치를 일차원 배열로 표현하는 것이 가능하다.

ex) arr[행] = 열
만일 (10,1) 이라면
arr[10] = 1; 
되는 거다 이런 심플한 생각이 나는 생각안났다 사람들이 천재다....



~~~java

    private static boolean check(int x, int[] board) {  
        for (int i = 0; i < x; i++) {  
            //같은 열에 다른 퀸이 존재할 경우  
            if(board[i] == board[x]){  
                return false;  
            }  
  
            //같은 대각선 상에 존재할 때  
            if(Math.abs(x - i) == Math.abs(board[x] - board[i])){  
                return false;  
            }  
  
        }  
        return true;  
    }  

~~~


마지막으로는 이 함수가 진짜 천재들이 한 생각이다. 일다 첫번째 if 문에서 각 행을 순회하면서 모든 행에서 같은 열에 퀸이 존재하는지 체크한다. 만일 같은 열에 존재한다면 사용이 불가능하다. 이후에는 같은 대각선에 있는 퀀이 있는지 확인 해야한다. 그리기 위해선 두 좌표가 이루는 기울기가 1 인경우를 찾아야한다. 따라서 다른 좌표의 퀀의 x 값 이번 x 값 다른 좌표의 퀀의 x값 그리고 다른 좌표의 y 값을 이용해서 절댓값을 구하고 같은 지 체크했다.


