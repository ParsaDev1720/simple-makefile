#include "inner.hh"

MyClass::MyClass(int value) : val(value)
{
}

int MyClass::get_val()
{
    return this->val;
}