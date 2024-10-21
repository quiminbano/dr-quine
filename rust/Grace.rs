use std::fs::File;
use std::io::Write;
use std::process::ExitCode;
/*
 comment in file
*/
macro_rules! print_in_file{($file_object:expr, $string:expr) => { { if let Err(_e) = $file_object.write($string.as_bytes()) { eprintln!("{}", "Writing to Grace_kid.rs failed"); return ExitCode::FAILURE; } } }; }
macro_rules! create_file{() => { { match File::create("Grace_kid.rs") { Ok(v) => v, Err(_e) => { eprintln!("{}", "Failed to create/modify Grace_kid.rs"); return ExitCode::FAILURE; } } } }; }
macro_rules! ft_main{() => { fn main() -> ExitCode { let vector: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char]; let string: String = format!("use std::fs::File;{0}use std::io::Write;{0}use std::process::ExitCode;{0}/*{0} comment in file{0}*/{0}macro_rules! print_in_file{2}($file_object:expr, $string:expr) => {2} {2} if let Err(_e) = $file_object.write($string.as_bytes()) {2} eprintln!({1}{2}{3}{1}, {1}Writing to Grace_kid.rs failed{1}); return ExitCode::FAILURE; {3} {3} {3}; {3}{0}macro_rules! create_file{2}() => {2} {2} match File::create({1}Grace_kid.rs{1}) {2} Ok(v) => v, Err(_e) => {2} eprintln!({1}{2}{3}{1}, {1}Failed to create/modify Grace_kid.rs{1}); return ExitCode::FAILURE; {3} {3} {3} {3}; {3}{0}macro_rules! ft_main{2}() => {2} fn main() -> ExitCode {2} let vector: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char]; let string: String = format!({1}{4}{1}, vector[0], vector[1], vector[2], vector[3], {1}{4}{1}); let file_object = create_file!(); print_in_file!(&file_object, &string); ExitCode::SUCCESS {3} {3}; {3}{0}{0}ft_main!();{0}", vector[0], vector[1], vector[2], vector[3], "use std::fs::File;{0}use std::io::Write;{0}use std::process::ExitCode;{0}/*{0} comment in file{0}*/{0}macro_rules! print_in_file{2}($file_object:expr, $string:expr) => {2} {2} if let Err(_e) = $file_object.write($string.as_bytes()) {2} eprintln!({1}{2}{3}{1}, {1}Writing to Grace_kid.rs failed{1}); return ExitCode::FAILURE; {3} {3} {3}; {3}{0}macro_rules! create_file{2}() => {2} {2} match File::create({1}Grace_kid.rs{1}) {2} Ok(v) => v, Err(_e) => {2} eprintln!({1}{2}{3}{1}, {1}Failed to create/modify Grace_kid.rs{1}); return ExitCode::FAILURE; {3} {3} {3} {3}; {3}{0}macro_rules! ft_main{2}() => {2} fn main() -> ExitCode {2} let vector: Vec<char> = vec![10 as char, 34 as char, 123 as char, 125 as char]; let string: String = format!({1}{4}{1}, vector[0], vector[1], vector[2], vector[3], {1}{4}{1}); let file_object = create_file!(); print_in_file!(&file_object, &string); ExitCode::SUCCESS {3} {3}; {3}{0}{0}ft_main!();{0}"); let file_object = create_file!(); print_in_file!(&file_object, &string); ExitCode::SUCCESS } }; }

ft_main!();
