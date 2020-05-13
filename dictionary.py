import json
import difflib

from difflib import SequenceMatcher
from difflib import get_close_matches

data = json.load(open("data.json"))




def translate(key):
    key = key.lower()
    if key in data:
        return data.get(key)
    elif len(get_close_matches(key, data.keys())) > 0:
        return "Did you mean %s instead?" % get_close_matches(key, data.keys())[0]
    else:
        return "The word does not exist. Please double check it."

def keep_running ():
    check = input("Would you like to search again? If yes, type 'Y,' if no, type 'N': ")
    
    if check.upper() == 'Y':
        return False
    else:
        spaces()
        print("Thank you for visiting our interactive dictionary!")
        spaces()
        return True
        
def spaces ():
    print("\n")

has_word_translated = False

while has_word_translated == False:

    word = input("Enter a word to find a definition for: ")
    spaces()
    output = translate(word)
    if type(output) == list:
        for item in output:
            print(item)
    else:
        print(output)

    if len(get_close_matches(word, data.keys())) > 0:
        if SequenceMatcher(None, word, get_close_matches(word, data.keys())[0]).ratio() == 1:
            spaces()
            has_word_translated = keep_running()
        else:
            yes_or_no = input("If yes type 'Y' if no type 'N': ")
            if yes_or_no.upper() == 'Y':
                spaces()
                output = data.get(get_close_matches(word, data.keys())[0])

                if type(output) == list:
                    for item in output:
                        print(item)
                else:
                    print(output)

                spaces()
                has_word_translated = keep_running()
            else:
                spaces()
                print("The word doesn't exist. Please double check it.")
                has_word_translated = keep_running()
    else:
        spaces()
        has_word_translated = keep_running()



