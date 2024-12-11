struct Solution {}

impl Solution {
    pub fn add_spaces(s: String, spaces: Vec<i32>) -> String {
        let mut result = String::new();

        for (i, space) in spaces.iter().enumerate() {
            result.push_str(&s[result.len() - i..*space as usize]);
            result.push(' ');
        }
        result.push_str(&s[result.len() - spaces.len()..]);
        result
    }
}


fn main() {
    let s = "LeetcodeHelpsMeLearn".to_string();
    let spaces = vec![8,13,15];
    let result = Solution::add_spaces(s, spaces);
    println!("Result: {}", result);
}
