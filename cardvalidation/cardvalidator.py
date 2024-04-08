import re

def credit_card(card_number):

    pattern = r'^[456]\d{3}(-?\d{4}){3}$'
    
    if re.match(pattern, card_number):   
        
        digits = card_number.replace('-', '')       # check for consecutive repeated digits and charecters
        if re.search(r'(\d)\1{2}', digits):
            return False
        else:
            return True
    else:
        return False

def main():
    card_number = input("Enter the credit card number: ")

    if  credit_card(card_number):
        print("Valid credit card number")
    else:
        print("Invalid credit card number")

if __name__ == "__main__":
    main()
