#include <iostream>

#include "inner_src/inner.hh" 


int main(int argc, char** argv)
{
    MyClass my_obj(45);
    std::cout << "Value: " << my_obj.get_val() << std::endl;
}