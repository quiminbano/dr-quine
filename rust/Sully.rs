use std::path::PathBuf;
use std::process::Command;
use std::fs::File;
use std::io::Write;
use std::env;
use std::error::Error;

fn execute_command(executable_name: &str, file_name : &str) -> Result<(), Box<dyn Error>>
{
    let command = Command::new("rustc").args(&[file_name, "-o", executable_name]).status().map_err(|e| {eprintln!("Error trying to compile the file: {}", file_name); e})?;
    if command.success()
    {
        Command::new(format!("./{}", executable_name)).status().map_err(|e| {eprintln!("Error trying to execute the file: {}", executable_name); e})?;
    }
    Ok(())
}

fn  check_executable_name() -> bool
{
    let index: usize;
    let executable_name: String;

    let path_exec = match env::current_exe()
    {
        Ok(path) => path,
        Err(_) => PathBuf::new()
    };
    let path_result = match path_exec.to_str()
    {
        Some(v) => v,
        None => ""
    };
    if path_result.is_empty()
    {
        return false;
    }
    index = match path_result.rfind('/')
    {
        Some(v) => v,
        None => 0 as usize
    };
    if index == 0
    {
        return false;
    }
    executable_name = path_result[index + 1..].to_string();
    if executable_name != "Sully"
    {
        return false;
    }
    return true;
}

fn main() -> Result<(), Box<dyn Error>>
{
	let	i: i32 = 5;
    let instruction_number: i32;
    if i <= 0
    {
        return Ok(());
    }
    if check_executable_name()
    {
        instruction_number = i;
    }
    else
    {
        instruction_number = i - 1;
    }
    let file_name: String = format!("Sully_{0}.rs", instruction_number);
    let executable_name: String = format!("Sully_{0}", instruction_number);
    let mut file = File::create(&file_name).map_err(|e| {eprintln!("Error trying to create the file: {}", e); e})?;
    let char_vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];
    let string: String = format!("use std::path::PathBuf;{0}use std::process::Command;{0}use std::fs::File;{0}use std::io::Write;{0}use std::env;{0}use std::error::Error;{0}{0}fn execute_command(executable_name: &str, file_name : &str) -> Result<(), Box<dyn Error>>{0}{2}{0}    let command = Command::new({1}rustc{1}).args(&[file_name, {1}-o{1}, executable_name]).status().map_err(|e| {2}eprintln!({1}Error trying to compile the file: {2}{3}{1}, file_name); e{3})?;{0}    if command.success(){0}    {2}{0}        Command::new(format!({1}./{2}{3}{1}, executable_name)).status().map_err(|e| {2}eprintln!({1}Error trying to execute the file: {2}{3}{1}, executable_name); e{3})?;{0}    {3}{0}    Ok(()){0}{3}{0}{0}fn  check_executable_name() -> bool{0}{2}{0}    let index: usize;{0}    let executable_name: String;{0}{0}    let path_exec = match env::current_exe(){0}    {2}{0}        Ok(path) => path,{0}        Err(_) => PathBuf::new(){0}    {3};{0}    let path_result = match path_exec.to_str(){0}    {2}{0}        Some(v) => v,{0}        None => {1}{1}{0}    {3};{0}    if path_result.is_empty(){0}    {2}{0}        return false;{0}    {3}{0}    index = match path_result.rfind('/'){0}    {2}{0}        Some(v) => v,{0}        None => 0 as usize{0}    {3};{0}    if index == 0{0}    {2}{0}        return false;{0}    {3}{0}    executable_name = path_result[index + 1..].to_string();{0}    if executable_name != {1}Sully{1}{0}    {2}{0}        return false;{0}    {3}{0}    return true;{0}{3}{0}{0}fn main() -> Result<(), Box<dyn Error>>{0}{2}{0}	let	i: i32 = {4};{0}    let instruction_number: i32;{0}    if i <= 0{0}    {2}{0}        return Ok(());{0}    {3}{0}    if check_executable_name(){0}    {2}{0}        instruction_number = i;{0}    {3}{0}    else{0}    {2}{0}        instruction_number = i - 1;{0}    {3}{0}    let file_name: String = format!({1}Sully_{2}0{3}.rs{1}, instruction_number);{0}    let executable_name: String = format!({1}Sully_{2}0{3}{1}, instruction_number);{0}    let mut file = File::create(&file_name).map_err(|e| {2}eprintln!({1}Error trying to create the file: {2}{3}{1}, e); e{3})?;{0}    let char_vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];{0}    let string: String = format!({1}{5}{1}, char_vec[0], char_vec[1], char_vec[2], char_vec[3], instruction_number, {1}{5}{1});{0}{0}    file.write(&string.as_bytes()).map_err(|e| {2}eprintln!({1}Error trying to write to the file: {2}{3}{1}, e); e{3})?;{0}    if instruction_number >= 0{0}    {2}{0}        execute_command(&executable_name, &file_name)?;{0}    {3}{0}    Ok(()){0}{3}{0}", char_vec[0], char_vec[1], char_vec[2], char_vec[3], instruction_number, "use std::path::PathBuf;{0}use std::process::Command;{0}use std::fs::File;{0}use std::io::Write;{0}use std::env;{0}use std::error::Error;{0}{0}fn execute_command(executable_name: &str, file_name : &str) -> Result<(), Box<dyn Error>>{0}{2}{0}    let command = Command::new({1}rustc{1}).args(&[file_name, {1}-o{1}, executable_name]).status().map_err(|e| {2}eprintln!({1}Error trying to compile the file: {2}{3}{1}, file_name); e{3})?;{0}    if command.success(){0}    {2}{0}        Command::new(format!({1}./{2}{3}{1}, executable_name)).status().map_err(|e| {2}eprintln!({1}Error trying to execute the file: {2}{3}{1}, executable_name); e{3})?;{0}    {3}{0}    Ok(()){0}{3}{0}{0}fn  check_executable_name() -> bool{0}{2}{0}    let index: usize;{0}    let executable_name: String;{0}{0}    let path_exec = match env::current_exe(){0}    {2}{0}        Ok(path) => path,{0}        Err(_) => PathBuf::new(){0}    {3};{0}    let path_result = match path_exec.to_str(){0}    {2}{0}        Some(v) => v,{0}        None => {1}{1}{0}    {3};{0}    if path_result.is_empty(){0}    {2}{0}        return false;{0}    {3}{0}    index = match path_result.rfind('/'){0}    {2}{0}        Some(v) => v,{0}        None => 0 as usize{0}    {3};{0}    if index == 0{0}    {2}{0}        return false;{0}    {3}{0}    executable_name = path_result[index + 1..].to_string();{0}    if executable_name != {1}Sully{1}{0}    {2}{0}        return false;{0}    {3}{0}    return true;{0}{3}{0}{0}fn main() -> Result<(), Box<dyn Error>>{0}{2}{0}	let	i: i32 = {4};{0}    let instruction_number: i32;{0}    if i <= 0{0}    {2}{0}        return Ok(());{0}    {3}{0}    if check_executable_name(){0}    {2}{0}        instruction_number = i;{0}    {3}{0}    else{0}    {2}{0}        instruction_number = i - 1;{0}    {3}{0}    let file_name: String = format!({1}Sully_{2}0{3}.rs{1}, instruction_number);{0}    let executable_name: String = format!({1}Sully_{2}0{3}{1}, instruction_number);{0}    let mut file = File::create(&file_name).map_err(|e| {2}eprintln!({1}Error trying to create the file: {2}{3}{1}, e); e{3})?;{0}    let char_vec: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char];{0}    let string: String = format!({1}{5}{1}, char_vec[0], char_vec[1], char_vec[2], char_vec[3], instruction_number, {1}{5}{1});{0}{0}    file.write(&string.as_bytes()).map_err(|e| {2}eprintln!({1}Error trying to write to the file: {2}{3}{1}, e); e{3})?;{0}    if instruction_number >= 0{0}    {2}{0}        execute_command(&executable_name, &file_name)?;{0}    {3}{0}    Ok(()){0}{3}{0}");

    file.write(&string.as_bytes()).map_err(|e| {eprintln!("Error trying to write to the file: {}", e); e})?;
    if instruction_number >= 0
    {
        execute_command(&executable_name, &file_name)?;
    }
    Ok(())
}
