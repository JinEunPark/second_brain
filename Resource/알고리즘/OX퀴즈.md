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
> https://www.acmicpc.net/problem/8958

### background Information


|시간 제한|메모리 제한|제출|정답|맞힌 사람|정답 비율|
|---|---|---|---|---|---|
|1 초|128 MB|217523|109979|90536|50.656%|

## 문제

"OOXXOXXOOO"와 같은 OX퀴즈의 결과가 있다. O는 문제를 맞은 것이고, X는 문제를 틀린 것이다. 문제를 맞은 경우 그 문제의 점수는 그 문제까지 연속된 O의 개수가 된다. 예를 들어, 10번 문제의 점수는 3이 된다.

"OOXXOXXOOO"의 점수는 1+2+0+0+1+0+0+1+2+3 = 10점이다.

OX퀴즈의 결과가 주어졌을 때, 점수를 구하는 프로그램을 작성하시오.

## 입력

첫째 줄에 테스트 케이스의 개수가 주어진다. 각 테스트 케이스는 한 줄로 이루어져 있고, 길이가 0보다 크고 80보다 작은 문자열이 주어진다. 문자열은 O와 X만으로 이루어져 있다.

## 출력

각 테스트 케이스마다 점수를 출력한다.

## 예제 입력 1 복사

5
OOXXOXXOOO
OOXXOOXXOO
OXOXOXOXOXOXOX
OOOOOOOOOO
OOOOXOOOOXOOOOX

## 예제 출력 1 복사

10
9
7
55
30

### Study

위 문제를 O(n) 만에 풀이하기 위해서 반복문을 뒤로 도는 것을 하지 않고 싶었다 따라서 O(n) 만에 해결하기 위해서는 투포인터를 이용했다.

~~~java
   public static int getAnswer(char[] x){  
        int[] y = new int[x.length];  
        int i = 0;  
        int j = -1;  
        while(i < x.length && j < x.length){  
            if(x[i] == 'O'){  
                y[i] = i - j;  
            }else{  
                y[i] = 0;  
                j = i;  
            }  
            i++;  
        }  
        return Arrays.stream(y).sum();  
    }  
~~~

초기에 i 와 j 라는 포인터를 사용했고 i 는 현재 인덱스를 가리키고 j 는 마지막 X 를 가르키도록 했다. 초기에 j 의 값을 몇을 설정해야하는지에 대해서 의문이 있었지만 -1 로 설정하면 처음에 O 가 존재하는 경우 그리고 X 가 존재하는 경우를 모두 처리할 수 있었다.


~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.*;  
  
public class Main {  
    public static int getAnswer(char[] x){  
        int[] y = new int[x.length];  
        int i = 0;  
        int j = -1;  
        while(i < x.length && j < x.length){  
            if(x[i] == 'O'){  
                y[i] = i - j;  
            }else{  
                y[i] = 0;  
                j = i;  
            }  
            i++;  
        }  
        return Arrays.stream(y).sum();  
    }  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        int n = Integer.parseInt(br.readLine());  
        List<char[]> inputs = new ArrayList<>();  
        for (int i = 0; i < n; i++) {  
            String input = br.readLine();  
            inputs.add(input.toCharArray());  
        }  
  
        int[] answers = new int[n];  
        for (int i = 0; i < n; i++) {  
            answers[i] = getAnswer(inputs.get(i));  
        }  
  
        Arrays.stream(answers).forEach(i -> System.out.println(i));  
    }  
}
~~~

### Trouble





### shooting
