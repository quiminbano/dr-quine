/*
 This comment is outside the function
*/
fn print_me(string: &str) {

    print!("{}", string);
}

fn main(){
/*
 Comment inside the program
*/
    let vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];
    let string: String = format!("/*{0} This comment is outside the function{0}*/{0}fn print_me(string: &str) {2}{0}{0}    print!({1}{2}{3}{1}, string);{0}{3}{0}{0}fn main(){2}{0}/*{0} Comment inside the program{0}*/{0}    let vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];{0}    let string: String = format!({1}{4}{1}, vec[0], vec[1], vec[2], vec[3], {4});{0}{0}    print_me(&string);{0}{3}", vec[0], vec[1], vec[2], vec[3], "/*{0} This comment is outside the function{0}*/{0}fn print_me(string: &str) {2}{0}{0}    print!({1}{2}{3}{1}, string);{0}{3}{0}{0}fn main(){2}{0}/*{0} Comment inside the program{0}*/{0}    let vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];{0}    let string: String = format!({1}{4}{1}, vec[0], vec[1], vec[2], vec[3], {4});{0}{0}    print_me(&string);{0}{3}");

    print_me(&string);
}