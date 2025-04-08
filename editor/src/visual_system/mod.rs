mod lexer;
mod parser;

use std::env;

pub fn init(){
    command();
}

fn command(){
    let args: Vec<String> = env::args().collect();

    if args.len() != 2{
        println!("args is not equal to 2");
    }
    else{
        println!("args is equal to 2");
    }
}