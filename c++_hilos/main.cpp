#include <iostream>
#include <iomanip>

using namespace std;

int main(int argc, char *argv[])
{
    for (int i = 0; i < argc; i++)
    {
        cout << "argv[" << i << "] = " << argv[i] << endl;
    }
    
    cout << "Hello World!" << endl;
    return 0;
}