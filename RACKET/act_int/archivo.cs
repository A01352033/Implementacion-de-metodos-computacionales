using System;

namespace MyNamespace {
    class MyClass {
        private int myPrivateField;

        public MyClass(int initialValue) {
            myPrivateField = initialValue;
        }

        public int MyProperty {
            get {
                return myPrivateField;
            }
            set {
                myPrivateField = value;
            }
        }

        public void MyMethod() {
            Console.WriteLine("The value of myPrivateField is: " + myPrivateField);
        }
    }
}

class Program {
    static void Main(string[] args) {
        MyClass myObject = new MyClass(42);
        myObject.MyProperty = 99;
        myObject.MyMethod();
    }
}
