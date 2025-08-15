#include <iostream>
#include <string>
#include <exception>

int division(int a,int b){
    try{
        int valor = a/b;
    }catch(const std::string e){
        std::cout<<"Mal"<< e.what();
    }
}

int main(){



    return 0;
}
