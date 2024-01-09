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
> [1번 문제 보물지도](https://school.programmers.co.kr/app/courses/16558/curriculum/lessons/163806)[2번 문제 벽부수기](https://www.acmicpc.net/problem/2206)
> [3번 말이되고 싶은 원숭이](https://www.acmicpc.net/problem/1600)
> 

저장!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

BFS 시간 복잡도  O(V + E) 노드 수 + 간선의 수 

[[BFS 메모리 초과]]
### background Information

간략하게 문제를 설명하자면 지도에서 목적지 까지 도달하는데 방향전환이 일어나면 가중치가 증가하는 개념이다 따라서 문제를 풀기 위해서는 직선도로를 많이 사용하는 것이 관건 처럼 보이지만 일부 지도에 막힌 부분이 존재하기 때문에 항상 그리디 알고리즘 만을 사용할 순없다는 것이다.

~~~java
package run;  
  
import java.util.*;  
class Solution {  
    public class Node{  
        public Node(int x, int y, int coner, int count, int dir) {  
            this.x = x;  
            this.y = y;  
            this.coner = coner;  
            this.count = count;  
            this.dir = dir;  
        }  
  
        int x;  
        int y;  
        int coner;  
        int count;  
        int dir = -1;//초기 방향 설정  
  
        @Override  
        public String toString() {  
            return "Node{" +  
                    "x=" + x +  
                    ", y=" + y +  
                    ", coner=" + coner +  
                    ", count=" + count +  
                    ", dir=" + dir +  
                    '}';  
        }  
    }  
    private int getFee(int coner, int count){  
        return coner * 600 + count * 100;  
    }  
    public int bfs(int[][]board, boolean[][] visited, int[][][] arr){  
        int[] dx = {1,-1,0,0};  
        int[] dy = {0,0,1,-1};  
        Queue<Node> q = new LinkedList<>();  
        int answer = Integer.MAX_VALUE;  
        q.add(new Node(0,0,0,0,-1));  
  
        while(!q.isEmpty()){  
            Node c = q.poll();  
            System.out.println(c);  
            if(c.x == board.length -1  && c.y == board.length-1){  
                answer = Math.min(answer, c.coner*600 + c.count * 100);  
            }  
            for (int i = 0; i < 4; i++) {  
                int nx = c.x + dx[i];  
                int ny = c.y + dy[i];  
                if(nx < 0 || nx >= board.length || ny < 0 || ny >= board.length || board[nx][ny] == 1){  
                    continue;  
                }  
                if(c.dir == -1){  
                    q.add(new Node(nx, ny, c.coner,c.count + 1, i));  
                }else{  
                    if(c.dir != i && arr[nx][ny][i] >= getFee(c.coner + 1, c.count)){  
                        arr[nx][ny][i] = getFee(c.coner + 1, c.count);  
                        q.add(new Node(nx,ny,c.coner + 1, c.count,i));  
                    }  
  
                    if(c.dir == i && arr[nx][ny][i] >= getFee(c.coner , c.count + 1)){  
                        arr[nx][ny][i] = getFee(c.coner, c.count+1);  
                        q.add(new Node(nx, ny, c.coner, c.count+1, i));  
                    }  
                }  
            }  
        }  
        return answer;  
    }  
    public int solution(int[][] board) {  
        int[][][] arr = new int[board.length][board.length][4];  
        for (int i = 0; i < arr.length; i++) {  
            for (int j = 0; j < board.length; j++) {  
                Arrays.fill(arr[i][j], Integer.MAX_VALUE);  
            }  
        }  
  
        return bfs(board,new boolean[board.length][board.length],arr);  
    }  
  
    public static void main(String[] args) {  
        Solution solution = new Solution();  
        int[][] board = new int[][]{ {0,0,0},{0,0,0},{0,0,0}};  
        System.out.println(solution.solution(board));  
    }  
}
~~~


### Study
BFS 의 시간 복잡도는 O(V + E) 이다. 따라서 왠만한 알고리즘 문제들은 적용가능하다. 
위의 코드에서는 다차원 방문 배열을 가진다고 설명할 수 있다.
위의 3차원 배열인 arr 에 하나의 셀당 4 개의 방향에서 접근한 건에 대해서 기록한다. 또한 한번의 방문이후 방문하는 방향 그리고 해당 방향으로 하나의 셀을 방문하는데 사용된 코스트를 기록한다. 또한 이미 방문한 배열의 셀보다 가격이 높은 비용을 가진다면 더이상 진행하지 않고 멈춘다. 


~~~java
 int[][][] arr = new int[board.length][board.length][4];  
        for (int i = 0; i < arr.length; i++) {  
            for (int j = 0; j < board.length; j++) {  
                Arrays.fill(arr[i][j], Integer.MAX_VALUE);  
            }  
        } 
~~~
위 문제를 풀이하는 가장 중요한 아이디어를 가진 코드가 위의 코드라고 생각한다.




~~~java
package run;  
  
import javax.print.DocFlavor;  
import java.io.*;  
import java.util.*;  
  
public class Main {  
    public static class Node {  
        int x;  
        int y;  
        int count;  
        int b;  
  
        public Node(int x, int y, int count, int b) {  
            this.x = x;  
            this.y = y;  
            this.count = count;  
            this.b = b;  
        }  
  
        @Override  
        public String toString() {  
            return "Node{" +  
                    "x=" + x +  
                    ", y=" + y +  
                    ", count=" + count +  
                    ", b=" + b +  
                    '}';  
        }  
    }  
  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int answer = Integer.MAX_VALUE;  
        int x = Integer.parseInt(st.nextToken()), y = Integer.parseInt(st.nextToken());  
        char[][] board = new char[x][y];  
        for (int i = 0; i < x; i++) {  
            board[i] = br.readLine().toCharArray();  
        }  
        //System.out.println(Arrays.deepToString(board));  
        int[] dx = {0, 0, 1, -1};  
        int[] dy = {1, -1, 0, 0};  
        boolean[][][] v = new boolean[x][y][2];  
        //1 벽 부수기전  
        //2 벽 부순 후  
        Queue<Node> q = new LinkedList<>();  
        q.add(new Node(0, 0, 1, 1));  
        v[0][0][1] = true;  
        v[0][0][0] = true;  
  
        while (!q.isEmpty()) {  
            Node c = q.poll();  
            //System.out.println(c);  
            if (c.x == x - 1 && c.y == y - 1) {  
                answer = Integer.min(answer, c.count);  
            }  
  
            for (int i = 0; i < 4; i++) {  
                int nx = c.x + dx[i];  
                int ny = c.y + dy[i];  
  
                int nnx = c.x + dx[i] * 2;  
                int nny = c.y + dy[i] * 2;  
  
                if (nx >= 0 && nx < x && ny >= 0 && ny < y) {  
                    if (board[nx][ny] != '1' && !v[nx][ny][c.b]) {  
                        v[nx][ny][c.b] = true;  
                        q.add(new Node(nx, ny, c.count + 1, c.b));  
                    }  
                    if (c.b == 1 && board[nx][ny] == '1' && nnx >= 0 && nnx < x && nny >= 0 && nny < y && board[nnx][nny] != '1' && !v[nnx][nny][0]) {  
                        v[nnx][nny][0] = true;  
                        q.add(new Node(nnx, nny, c.count + 2, 0));  
                    }  
                }  
  
            }  
        }  
        if(answer == Integer.MAX_VALUE) answer = -1;  
        System.out.println(answer);  
    }  
}
~~~
### Trouble





### shooting



### backgroundInformation

문제에 대해서 설명하자면 원숭이가 목적지까지 가는데 지도에 벽이 존재하고 가는데 필요한 코스트가 줄어드는 경우에는 한번은 벽을 뚫고 가게 할 수 있다는 것이다. 아래 문제를 풀기 위해서는 상태 전이를 위해서 필요시 정의한 벽은 뚫을 수 있는 상태의 v 지도와 벽을 뚫을 수 없는 경우의 v를 분리해야한다는 것이다.

~~~java
package run;  
  
import javax.print.DocFlavor;  
import java.io.*;  
import java.util.*;  
  
public class Main {  
    public static class Node {  
        int x;  
        int y;  
        int count;  
        int b;  
  
        public Node(int x, int y, int count, int b) {  
            this.x = x;  
            this.y = y;  
            this.count = count;  
            this.b = b;  
        }  
  
        @Override  
        public String toString() {  
            return "Node{" +  
                    "x=" + x +  
                    ", y=" + y +  
                    ", count=" + count +  
                    ", b=" + b +  
                    '}';  
        }  
    }  
  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int answer = Integer.MAX_VALUE;  
        int x = Integer.parseInt(st.nextToken()), y = Integer.parseInt(st.nextToken());  
        char[][] board = new char[x][y];  
        for (int i = 0; i < x; i++) {  
            board[i] = br.readLine().toCharArray();  
        }  
        //System.out.println(Arrays.deepToString(board));  
        int[] dx = {0, 0, 1, -1};  
        int[] dy = {1, -1, 0, 0};  
        boolean[][][] v = new boolean[x][y][2];  
        //1 벽 부수기전  
        //2 벽 부순 후  
        Queue<Node> q = new LinkedList<>();  
        q.add(new Node(0, 0, 1, 1));  
        v[0][0][1] = true;  
        v[0][0][0] = true;  
  
        while (!q.isEmpty()) {  
            Node c = q.poll();  
            //System.out.println(c);  
            if (c.x == x - 1 && c.y == y - 1) {  
                answer = Integer.min(answer, c.count);  
            }  
  
            for (int i = 0; i < 4; i++) {  
                int nx = c.x + dx[i];  
                int ny = c.y + dy[i];  
  
                int nnx = c.x + dx[i] * 2;  
                int nny = c.y + dy[i] * 2;  
  
                if (nx >= 0 && nx < x && ny >= 0 && ny < y) {  
                    if (board[nx][ny] != '1' && !v[nx][ny][c.b]) {  
                        v[nx][ny][c.b] = true;  
                        q.add(new Node(nx, ny, c.count + 1, c.b));  
                    }  
                    if (c.b == 1 && board[nx][ny] == '1' && nnx >= 0 && nnx < x && nny >= 0 && nny < y && board[nnx][nny] != '1' && !v[nnx][nny][0]) {  
                        v[nnx][nny][0] = true;  
                        q.add(new Node(nnx, nny, c.count + 2, 0));  
                    }  
                }  
  
            }  
        }  
        if(answer == Integer.MAX_VALUE) answer = -1;  
        System.out.println(answer);  
    }  
}
~~~





~~~java
package run;  
  
import javax.print.DocFlavor;  
import java.io.*;  
import java.util.*;  
  
public class Main {  
    public static class Node {  
        int x;  
        int y;  
        int k;  
        int count;  
  
        public Node(int x, int y, int k, int count) {  
            this.x = x;  
            this.y = y;  
            this.k = k;  
            this.count = count;  
        }  
  
        @Override  
        public String toString() {  
            return "Node{" +  
                    "x=" + x +  
                    ", y=" + y +  
                    ", k=" + k +  
                    ", count=" + count +  
                    '}';  
        }  
    }  
  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        StringTokenizer st = new StringTokenizer(br.readLine());  
        int k = Integer.parseInt(st.nextToken());  
  
        st = new StringTokenizer(br.readLine());  
        int w = Integer.parseInt(st.nextToken());  
        int h = Integer.parseInt(st.nextToken());  
  
        int answer = Integer.MAX_VALUE;  
  
        char[][] b = new char[h][w];  
  
        for (int i = 0; i < h; i++) {  
            b[i] = br.readLine().replaceAll(" ","").toCharArray();  
        }  
          
        int[][][] v = new int[h][w][k + 1];  
        for (int i = 0; i < h; i++) {  
            for (int j = 0; j < w; j++) {  
                Arrays.fill(v[i][j], Integer.MAX_VALUE);  
            }  
        }  
  
        int[] dx = {0, 0, 1, -1};  
        int[] dy = {1, -1, 0, 0};  
  
        int[] ddx = {-1, -2, -2, -1, 1, 2, 2, 1};  
        int[] ddy = {-2, -1, 1, 2, 2, 1, -1, -2};  
  
        Queue<Node> q = new LinkedList<>();  
        q.add(new Node(0, 0, k, 0));  
  
        while (!q.isEmpty()) {  
            Node c = q.poll();  
  
            if (c.x == h - 1 && c.y == w - 1) {  
                answer = Math.min(c.count, answer);  
                continue;            }  
  
            for (int i = 0; i < 4; i++) {  
                int nx = c.x + dx[i];  
                int ny = c.y + dy[i];  
  
                if (nx >= 0 && nx < h && ny >= 0 && ny < w && b[nx][ny] != '1') {  
  
                    if (v[nx][ny][c.k] > c.count + 1) {  
                        v[nx][ny][c.k] = c.count + 1;  
                        q.add(new Node(nx, ny, c.k, c.count + 1));  
  
                    }  
                }  
            }  
  
            if (c.k != 0) {  
                for (int i = 0; i < 8; i++) {  
  
                    int nnx = c.x + ddx[i];  
                    int nny = c.y + ddy[i];  
  
                    if (nnx >= 0 && nnx < h && nny >= 0 && nny < w && b[nnx][nny] != '1') {  
                        if (v[nnx][nny][c.k - 1] > c.count + 1) {  
                            v[nnx][nny][c.k - 1] = c.count + 1;  
                            q.add(new Node(nnx, nny, c.k - 1, c.count + 1));  
                        }  
                    }  
                }  
            }  
        }  
  
        if (answer == Integer.MAX_VALUE) answer = -1;  
        System.out.println(answer);  
    }  
}
~~~