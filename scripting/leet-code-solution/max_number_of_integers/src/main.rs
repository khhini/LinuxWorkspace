use std::collections::HashSet;

pub struct Solution {}

impl Solution {
    pub fn max_count(banned: Vec<i32>, n: i32, max_sum: i32) -> i32 {
        let banned_set = banned.into_iter().collect::<HashSet<i32>>();
        let mut ans = 0;
        let mut sum = 0;

        for i in 1..=n { 
            if sum + i > max_sum {
                break;
            }
            if banned_set.contains(&i) {
                continue;
            }
            sum += i;
            ans += 1;
        }
        ans
    }
}

fn main() {
    let banned = vec![1, 6, 5];
    let n = 5; // 1, 2, 3, 4, 5
    let max_sum = 6;
    println!("{}",Solution::max_count(banned, n, max_sum));

    let banned = vec![1,2,3,4,5,6,7];
    let n = 8; // 1, 2, 3, 4, 5, 6, 7, 8
    let max_sum = 1;
    println!("{}",Solution::max_count(banned, n, max_sum));

    let banned = vec![11];
    let n = 7; // 1, 2, 3, 4, 5, 6, 7
    let max_sum = 50;
    println!("{}",Solution::max_count(banned, n, max_sum));

}
