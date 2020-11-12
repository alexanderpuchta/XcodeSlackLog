// 
// Created by Alexander Puchta in 2020
// 
// 

struct LogOutputStream: TextOutputStream {
    
    mutating func write(_ string: String) {
        print(string)
    }
}
