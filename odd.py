#this program checks input value and prints out "odd number" or "even number"
number=int(input("Enter a number: "))
def check_number(number):
    if number % 2 == 0:
        print("Its an even number")
    else:
        print("Its an odd number")
check_number(number)