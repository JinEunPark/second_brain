---
tags:
  - "#algo"
last updated: 
due date: 
Project: 
aliases:
---
--- 
### tasks

> [! Todo] Title
> https://school.programmers.co.kr/tryouts/71915/challenges

문제는 요약하면 n 이라는 자연수를 k 진법을 가진 수로 바꾸고 해당 수를 10진법의 소수 갯수를 구하는 것이다.
### Trouble
테스트 케이스 1번 과 11 번에서 오류가 발생했다. 
초기에는 공백에 의한 NumberFormatException 이라고 생각해서 아래와 같은 풀이를 만들었다.
~~~java
class Solution {  
    public static boolean isInteger(String strValue) {  
        try {  
            Integer.parseInt(strValue);  
            return true;        } catch (NumberFormatException ex) {  
            return false;  
        }  
    }  
  
    public boolean isPrime(int num){  
        if(num == 1){  
            return false;  
        }  
        for (int i = 2; i < num; i++) {  
            if((num % i) == 0) return false;  
        }  
        return true;  
    }  
    public int solution(int n, int k) {  
        int answer = 0;  
        String kNum = Integer.toString(n,k);  
        StringTokenizer st = new StringTokenizer(kNum,"0");  
        while(st.hasMoreTokens()){  
            String o = st.nextToken();  
            long num = Integer.parseInt(o);  
            if(isPrime(num)) answer++;  
        }  
        return answer;  
    }  
}
~~~

위의 함수로 구현해서 number format exception이라면 어차피 소수를 반환할것이라고 생각해서 구현했다. 하지만 정답은 아니였다. 하지만 위의 함수처럼 number format exception 으로 함수를 만들 수 있는지는 몰랐다.

한참이 지나서야 알게되었다 숫자의 범위를...
### shooting

1. 문제속에서는 n 의 범위가 1,000,000 까지라고 하고 있다. Integer 의 범위는 21억 까지 당연하게도 연산이 가능할것이라고 생각했다 하지만 컴퓨터는 나눗셈과 곱샘과정에서 피승수와 승수의 두배의 레지스터가 필요하다 따라서 백만은 약 2^20 이를 모듈러 연산을 사용하지 위해서는 약 2^40 만큼이 필요하다. 따라서 이를 해결하기 위해서 int -> long 으로 변경했다
2. 하지만 두번째 문제는 소수를 구하는과정에서의 시간 복잡도였다. 기본적으로 위의 반복문으로 간다며 logN 의 시간이 소요된다 하지만 소수는 자기 자신과 1을 약수로 가진다 따라서 이를 위해서 전범위를 구하는 것이 아니라 루트 만큼의 수만 검증한다면 나머지는 계산하지 않아도 된다. 9 = 3^2 이기 때문에 3까지만 구해도 되는 것처럼 따라서 Math.sprt() 를 이용해서 제곱근 까지만 구했다. 이후 반복문 수행 마지막 정잡 코드
3.         for(int i = 2; i <= Math.sqrt(v); i++)

~~~java
class Solution {  
    public boolean isPrime(long num) {  
        if (num == 1) {  
            return false;  
        }  
        for (int i = 2; i < Math.sqrt(num); i++) {  
            if ((num % i) == 0) return false;  
        }  
        return true;  
    }  
  
    public int solution(int n, int k) {  
        int answer = 0;  
        String kNum = Integer.toString(n, k);  
        StringTokenizer st = new StringTokenizer(kNum, "0");  
        while (st.hasMoreTokens()) {  
            String o = st.nextToken();  
            long num = Long.parseLong(o);  
            if (isPrime(num)) answer++;  
        }  
        return answer;  
    }  
}
~~~

