#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode {
            next: None,
            val
        }
    }
}
fn main() {
    let l1 = Box::new(ListNode{
        val: 9,
        next: Some(Box::new(ListNode{
            val: 9,
            next: Some(Box::new(ListNode::new(9)))
        }))
    });
}
