// it should be noted that right now this uses Rust's file system, but later on it WILL use a custom one built into the engine itself


use std::fs::File;


pub enum TokenType {
    //identity of Token
    IDENT,
    //math tokens
    ADD,
    SUB,
    DIV,
    MULT,
    //program tokens
    PROG,
    ENDPROG,
    SYS,
    //Integer tokens
    U8,
    U16,
    U32,
    U64,
    I8,
    I16,
    I32,
    I64,
    //Floating point tokens
    FLOAT,
    DOUBLE,
    //Syntax stuff
    BRACKET
    

}

pub struct Token{
    token_type: TokenType,
    lexeme: String
}

