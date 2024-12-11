use std::collections::HashMap;

struct Solution {}

impl Solution {
    fn two_sum(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let mut hash_map: HashMap<&i32, i32> = HashMap::new();

        for (i, num) in nums.iter().enumerate() {
            let diff = target - num;
            if let Some(&index) = hash_map.get(&diff) {
                return vec![index, i as i32];
            }
            hash_map.insert(num, i as i32);
        }

        vec![]
    }
}

fn main() {
    let nums = vec![2, 7, 11, 15];
    let target = 9;

    let result = Solution::two_sum(nums, target);

    println!("{:?}", result);

    let nums = vec![3, 2, 4];
    let target = 6;

    let result = Solution::two_sum(nums, target);

    println!("{:?}", result);
}
