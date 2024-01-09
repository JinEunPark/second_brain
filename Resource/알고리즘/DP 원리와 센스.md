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
> https://school.programmers.co.kr/learn/courses/30/lessons/12971

문제는 다음과 같다 원안에 적힌 숫자에서 하나를 골라서 더하는데 하나를 고르면 양옆이 수는 고를 수 없게 된다 포인트는 0 번째 수를 고르면 원이기 때문에 마지막 수와 첫번째 수는 고를  수 없게 되는 것이다.


### background Information

이 문제는 n 100000이기 때문에 다이나믹 프로그래밍으로 접근해야했다 처음엔 재귀로 접근했다가 망했다... 



### Study
~~~java
class Solution {
    public int solution(int sticker[]) {
        int answer = 0;
        int[] max = new int[sticker.length-1];
        int[] max2 = new int[sticker.length];

        if(sticker.length == 1) return sticker[0];
        if(sticker.length == 2) return sticker[0] > sticker[1] ? sticker[0]: sticker[1];
        max[0] = sticker[0];
        max[1] = sticker[0];
        for(int i = 2; i < max.length; i++){
            int cur = max[i-1] > (max[i-2] + sticker[i])? max[i-1] : (max[i-2] + sticker[i]);
            max[i] = cur;
        }
        
        max2[0] = 0;
        max2[1] = sticker[1];
        for(int i = 2; i < max2.length; i++){
            int cur = max2[i-1] > (max2[i-2] + sticker[i])? max2[i-1] : (max2[i-2] + sticker[i]);
            max2[i] = cur;
        }

        return max[max.length-1] > max2[max2.length-1] ? max[max.length-1] : max2[max2.length-1];
    }
}
~~~


### Trouble
처음에 만들어낸 재귀는 다음과 같다 
max[i] = max[i-1] > max[i-2] + sticker[i]
하지만 처음에는 이렇게 만들면 처음 숫자를 선택했을 때 마지막 인덱스의 수를 뽑을 수 없다는 것을 어떻게 구현할지 막막했다.

### shooting
처음 수를 뽑은 경우와 뽑지 않은 경우를 구분하기 위해서 두가지의 배열을 한번에 사용해서 문제를 풀었다. 다라서 
처음 수를 사용한 경우에 양옆의 수를 사용할 수 없으니 0,1  을 모두 0 의 값으로 초기화했다.
또한 중요한 점은 마지막 값또한 사용할 수 없으므로 max 배열의 크기를 하나 줄여서 반복문을 수행하는 것이 중요하다.
max[0] = sticker[0];
max[1] = sticker[0];

두번째는 첫번째 값을 사용하지 않는 경우이다. 이 경우에는 처음 값이 다른 값에 영향을 줄수 없어서 첫번째와 두번째 max 를 0, 과 원래의 숫자로 초기화 한뒤에 재귀를 수행하면된다.  또한 배열도 원래대로 끝까지 반복문을 수행하면된다.

max2[0] = 0;
max2[1] = sticker[1];




~~~java
package run;  
  
import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.util.Arrays;  
  
public class Main {  
  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        int n = Integer.parseInt(br.readLine());  
        int answer = 0;  
        int[] memo = new int[1000004];  
  
        memo[1] = 0;  
        memo[2] = 1;  
        memo[3] = 1;  
  
  
        int num = 4;  
  
        while(num  <= n){  
            int x = Integer.MAX_VALUE, y = Integer.MAX_VALUE,z;  
            boolean xx = false, yy= false;  
  
            if(num % 3 == 0){  
                x = num/3;  
                xx= true;  
            }  
  
            if(num % 2 == 0){  
                y = num/2;  
                yy= true;  
            }  
  
            z = num -1;  
  
            if(xx && yy){  
                memo[num] = Integer.min(memo[x] + 1 ,Integer.min(memo[y] + 1,memo[z] + 1));  
            } else if (xx) {  
                memo[num] = Integer.min(memo[x] + 1 ,memo[z] + 1);  
            }else if (yy){  
                memo[num] = Integer.min(memo[z] + 1 ,memo[y] + 1);  
            }else{  
                memo[num] = memo[z] + 1;  
            }  
            //System.out.println(Arrays.toString(memo));  
            num++;  
        }  
        System.out.println(memo[n]);  
    }  
  
//  
//    public static void main(String[] args) throws IOException {  
//        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
//        int n = Integer.parseInt(br.readLine());  
//  
//        int[] me = new int[n+4];  
//        me[0] = 0;  
//        me[1] = 0;  
//        me[2] = 1;  
//        me[3] = 1;  
//        for (int i = 4; i <= n; i++) {  
//            int[] result = new int[3];  
//            Arrays.fill(result,Integer.MAX_VALUE);  
//            if(i % 2 == 0){  
//                result[0] = me[i/2]+1;  
//            }  
//  
//            if(i % 3 == 0){  
//                result[1] = me[i/3]+1;  
//            }  
//            result[2] =  me[i-1]+1;  
//            me[i] = Arrays.stream(result).min().getAsInt();  
//        }  
//        System.out.println(me[n]);  
//    }  
}
~~~

