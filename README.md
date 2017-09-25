# mastermind
Mastermind challenge from Hopson Discord server.

Accepts these optional paramaters:

`-easy` - Easy mode, displays the positions of the characters you have guessed correctly.

`-self` - The program will solve the word itself 

`lives <amount>` - Set the amount of lives you want you/the computer to have (7 by default).

`length <amount>` - Set the length of the word (random by default).

`wordlist <local_file_name>` - Set the word list the program uses to the given local file (local wordslist.txt by default.)

e.g, `ruby mm.rb -self wordlist otherlist.txt lives 10 length 5`
