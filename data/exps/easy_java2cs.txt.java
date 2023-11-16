public void merge(int[] nums1, int m, int[] nums2, int n){for(int j = 0, i = m;j < n;j++){nums1[i] = nums2[j];i++;}Arrays.sort(nums1);}
public List<Double> averageOfLevels(TreeNode root){List<Double> result = new ArrayList<>();Queue<TreeNode> q = new LinkedList<>();if(root == null) return result;q.add(root);while(!q.isEmpty()){int n = q.size();double sum = 0.0;for(int i = 0;i < n;i++){TreeNode node = q.poll();sum += node.val;if(node.left != null) q.offer(node.left);if(node.right != null) q.offer(node.right);}result.add(sum / n);}return result;}
public class Solution{int minDiff = Integer.MAX_VALUE;TreeNode prev;public int getMinimumDifference(TreeNode root){inorder(root);return minDiff;}public void inorder(TreeNode root){if(root == null) return;inorder(root.left);if(prev != null) minDiff = Math.min(minDiff, root.val - prev.val);prev = root;inorder(root.right);}}
public boolean isAnagram(String s, String t){int[] alphabet = new int[26];for(int i = 0;i < s.length();i++) alphabet[s.charAt(i) - 'a']++;for(int i = 0;i < t.length();i++) alphabet[t.charAt(i) - 'a']--;for(int i : alphabet) if(i != 0) return false;return true;}
public List<String> summaryRanges(int[] nums){ArrayList<String> al=new ArrayList<>();for(int i=0;i<nums.length;i++){int start=nums[i];while(i+1<nums.length && nums[i]+1==nums[i+1]) i++;if(start!=nums[i]){al.add(""+start+"->"+nums[i]);}else{al.add(""+start);}}return al;}
public boolean isValid(String s){Stack<Character> stack = new Stack<Character>();for(char c : s.toCharArray()){if(c == '(') stack.push(')');else if(c == '{') stack.push('}');else if(c == '[') stack.push(']');else if(stack.isEmpty() || stack.pop() != c) return false;}return stack.isEmpty();}
public boolean hasCycle(ListNode head){ListNode slow = head, fast = head;while(fast != null && fast.next != null){slow = slow.next;fast = fast.next.next;if(slow == fast) return true;}return false;}
public ListNode mergeTwoLists(ListNode l1, ListNode l2){ListNode head = new ListNode(0);ListNode handler = head;while(l1 != null && l2 != null){if(l1.val <= l2.val){handler.next = l1;l1 = l1.next;}else{handler.next = l2;l2 = l2.next;}handler = handler.next;}if(l1 != null){handler.next = l1;}else if(l2 != null){handler.next = l2;}return head.next;}
class Solution{public boolean rootToLeafPathSum(TreeNode root, int targetSum, int sum){if(root == null) return false;if(root.left == null && root.right == null){sum = sum + root.val;if(sum == targetSum) return true;}return rootToLeafPathSum(root.left, targetSum, sum + root.val) || rootToLeafPathSum(root.right, targetSum, sum + root.val);}public boolean hasPathSum(TreeNode root, int targetSum){int sum = 0;return rootToLeafPathSum(root, targetSum, sum);}}
