class Solution { public void merge(int[] nums1, int m, int[] nums2, int n) { for (int j = 0, i = m; j < n; j++) { nums1[i] = nums2[j]; i++; } Arrays.sort(nums1); } }
class Solution { private Integer[][] memo; public int minimumTotal(List<List<Integer>> triangle) { int n = triangle.size(); memo = new Integer[n][n]; return dfs(0, 0, triangle); } private int dfs(int level, int i, List<List<Integer>> triangle) { if (memo[level][i] != null) return memo[level][i]; int path = triangle.get(level).get(i); if (level < triangle.size() - 1) path += Math.min(dfs(level + 1, i, triangle), dfs(level + 1, i + 1, triangle)); return memo[level][i] = path; } }
class Solution { public int maxProfit(int k, int[] prices) { int n = prices.length; if (n <= 1) return 0; if (k >= n/2) { int maxPro = 0; for (int i = 1; i < n; i++) { if (prices[i] > prices[i-1]) maxPro += prices[i] - prices[i-1]; } return maxPro; } int[][] dp = new int[k+1][n]; for (int i = 1; i <= k; i++) { int localMax = dp[i-1][0] - prices[0]; for (int j = 1; j < n; j++) { dp[i][j] = Math.max(dp[i][j-1], prices[j] + localMax); localMax = Math.max(localMax, dp[i-1][j] - prices[j]); } } return dp[k][n-1]; } }