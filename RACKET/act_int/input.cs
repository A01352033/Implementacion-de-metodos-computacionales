/* Codigo de ejemplo en C# de Manuel Villalpando Linares */
// 14/04/2023

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


/* program #2 */
    class Program
    {
        static void Main(string[] args)
        {
            int num1 = 5;
            int num2 = 10;
            string message = "Hello, world!";
            
            Console.WriteLine(message);

            if (num1 < num2)
            {
                Console.WriteLine("num1 is less than num2");
            }
            else
            {
                Console.WriteLine("num1 is greater than or equal to num2");
            }

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine("The value of i is " + i);
            }

            while (num1 < 10)
            {
                Console.WriteLine("num1 is less than 10");
                num1++;
            }

            switch (num2)
            {
                case 1:
                    Console.WriteLine("num2 is 1");
                    break;
                case 5:
                    Console.WriteLine("num2 is 5");
                    break;
                default:
                    Console.WriteLine("num2 is neither 1 nor 5");
                    break;
            }

            string[] names = {"Alice", "Bob", "Charlie"};
            foreach (string name in names)
            {
                Console.WriteLine("Hello, " + name);
            }

            Console.ReadLine();
        }
    }
}
