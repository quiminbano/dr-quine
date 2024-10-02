use std::process::Command;
use std::fs::File;
use std::io::{self, Write};

fn execute_command(executable_name: &str, file_name : &str)
{
    let command = Command::new("rustc").args(&[file_name, "-o", executable_name]).status().expect(format!("Failed to compile {}.", executable_name).as_str());
    if command.success()
    {
        Command::new(format!("./{}", executable_name)).status().expect(format!("Failed to execute the binary {}.", executable_name).as_str());
    }
}
fn main() -> i32
{
	let	i: i32 = 5;
    if i <= 0
    {
        return 0;
    }
    let mut instruction_number: i32 = i - 1;
    match File::open("Sully_5.rs")
    {
        Ok(_) => instruction_number = i - 1,
        Err(e) => 
        {
            if e.kind() == io::ErrorKind::NotFound
            {
                instruction_number = i;
            }
            else
            {
                eprintln!("Error trying to open Sully_5 executable");
                return 1;
            }
        }
    }
    let file_name: String = format!("Sully_{0}.rs", instruction_number);
    let executable_name: String = format!("Sully_{0}", instruction_number);
    let mut file = File::create(&file_name).expect("Error creating the file");
    let char_vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];
    let string: String = format!("use std::process::Command;{0}use std::fs::File;{0}use std::io::Write;{0}{0}fn execute_command(executable_name: &str, file_name : &str) {2}{0}    let command = Command::new({1}rustc{1}).args(&[file_name, {1}-o{1}, executable_name]).status().expect(format!({1}Failed to compile {2}{3}.{1}, executable_name).as_str());{0}    if command.success() {2}{0}        Command::new(format!({1}./{2}{3}{1}, executable_name)).status().expect(format!({1}Failed to execute the binary {2}{3}.{1}, executable_name).as_str());{0}    {3}{0}{3}{0}fn main() {2}{0}	let	i: u32 = {4};{0}    if i != 0 {2}{0}        let file_name: String = format!({1}Sully_{2}0{3}.rs{1}, (i - 1));{0}        let executable_name: String = format!({1}Sully_{2}0{3}{1}, (i - 1));{0}        let mut file = File::create(&file_name).expect({1}Error creating the file{1});{0}        let char_vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];{0}        let string: String = format!({1}{5}{1}, char_vec[0], char_vec[1], char_vec[2], char_vec[3], (i - 1), {1}{5}{1});{0}{0}        file.write(&string.as_bytes()).expect({1}Error trying to write to the file{1});{0}        if i - 1 != 0 {2}{0}            execute_command(&executable_name, &file_name);{0}        {3}{0}    {3}{0}{3}{0}", char_vec[0], char_vec[1], char_vec[2], char_vec[3], instruction_number, "use std::process::Command;{0}use std::fs::File;{0}use std::io::Write;{0}{0}fn execute_command(executable_name: &str, file_name : &str) {2}{0}    let command = Command::new({1}rustc{1}).args(&[file_name, {1}-o{1}, executable_name]).status().expect(format!({1}Failed to compile {2}{3}.{1}, executable_name).as_str());{0}    if command.success() {2}{0}        Command::new(format!({1}./{2}{3}{1}, executable_name)).status().expect(format!({1}Failed to execute the binary {2}{3}.{1}, executable_name).as_str());{0}    {3}{0}{3}{0}fn main() {2}{0}	let	i: u32 = {4};{0}    if i != 0 {2}{0}        let file_name: String = format!({1}Sully_{2}0{3}.rs{1}, (i - 1));{0}        let executable_name: String = format!({1}Sully_{2}0{3}{1}, (i - 1));{0}        let mut file = File::create(&file_name).expect({1}Error creating the file{1});{0}        let char_vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];{0}        let string: String = format!({1}{5}{1}, char_vec[0], char_vec[1], char_vec[2], char_vec[3], (i - 1), {1}{5}{1});{0}{0}        file.write(&string.as_bytes()).expect({1}Error trying to write to the file{1});{0}        if i - 1 != 0 {2}{0}            execute_command(&executable_name, &file_name);{0}        {3}{0}    {3}{0}{3}{0}");

    file.write(&string.as_bytes()).expect("Error trying to write to the file");
    if instruction_number >= 0
    {
        execute_command(&executable_name, &file_name);
    }
    0
}
