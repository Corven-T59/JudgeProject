import java.io.*;
import java.util.*;

public class Product {

  public static void main(String[] args) throws Exception {
    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
    String line = null;

    while ((line = br.readLine()) != null) {
      String[] tokens = line.split(" ");
      int n = Integer.parseInt(tokens[0]), k = Integer.parseInt(tokens[1]);

      // Create Fenwick trees for the cumulative frequencies of zeros and negatives
      int[] values = new int[n];
      FenwickTree fz = new FenwickTree(n); // Zeros
      FenwickTree fn = new FenwickTree(n); // Negatives

      tokens = br.readLine().split(" ");
      for (int i = 0; i < n; i++) {
        int x = Integer.parseInt(tokens[i]);
        values[i] = x;
        if (x == 0) {
          fz.adjust(i+1, 1);
        }
        else if (x < 0) {
          fn.adjust(i+1, 1);
        }
      }

      for (int command = 0; command < k; command++) {
        tokens = br.readLine().split(" ");
        int i = Integer.parseInt(tokens[1]), j = Integer.parseInt(tokens[2]);

        if (tokens[0].equals("C")) {
          int prevValue = values[i-1];
          values[i-1] = j;

          // No significant change
          if (prevValue == j || (prevValue < 0 && j < 0) || (prevValue > 0 && j > 0)) {
            continue;
          }

          // Adjust for previous value loss
          if (prevValue == 0) {
            fz.adjust(i, -1);
          }
          else if (prevValue < 0) {
            fn.adjust(i, -1);
          }

          // Adjust for new value gain
          if (j == 0) {
            fz.adjust(i, 1);
          }
          else if (j < 0) {
            fn.adjust(i, 1);
          }
        }
        else {
          int numZeros = fz.rsq(i, j);
          int numNegatives = fn.rsq(i, j);

          // Print zero if more than one 0 occurs in range
          if (numZeros > 0) {
            System.out.print('0');
          }
          // Print - if an odd number of negative numbers appear in range
          else if ((numNegatives % 2) == 1) {
            System.out.print('-');
          }
          // Print + otherwise
          else {
            System.out.print('+');
          }
        }
      }

      System.out.println();
    }
  }

}

class FenwickTree {
  private int[] ft;

  public FenwickTree(int n) {
    this.ft = new int[n + 1];
  }

  public int rsq(int b) {
    int sum = 0;
    while (b != 0) {
      sum += ft[b];
      b -= LSOne(b);
    }
    return sum;
  }

  public int rsq(int a, int b) {
    return rsq(b) - (a == 1 ? 0 : rsq(a - 1));
  }

  public void adjust(int k, int v) {
    while (k < ft.length) {
      ft[k] += v;
      k += LSOne(k);
    }
  }

  public int LSOne(int s) {
    return s & (-s);
  }
}
