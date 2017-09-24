words = File.readlines("wordslist.txt");
word = words.sample.chomp;

s = word.size

lives = 6;

if(ARGV[0] == "lives" || ARGV[1] == "lives") # optional param to set amount of lives 
	a = 1
	if(arg == "lives") then a = 0 end
	if(!ARGV[a]) 
		puts "You need to specify an amount of lives! e.g., `ruby mm.rb lives 8`"
		exit
	end
	
	amnt = ARGV[a+1].to_i-1
	
	if(amnt < 0)
		puts "Make sure the amount of lives is greater than 0."
		exit
	end
	
	lives = amnt
end 

mode = 0

if(ARGV[0] == "-easy") then mode = 1 end 
if(ARGV[2] == "-easy") then mode = 1 end
if(ARGV[0] == "-self") then mode = 2 end
if(ARGV[2] == "-self") then mode = 2 end

def s(g, w)
	return g.chomp.each_char.zip(w.each_char).count{|g,w|g==w};
end

def matchingLength(matching)
	size = 0
	for i in matching do 
		if(i != ".") then size += 1 end 
	end
	return size 
end

rword = true 
matching = [] # . represents an unknown char

if(mode == 0 || mode == 1) 
	puts "The word is " + s.to_s + " characters long."
	while true 
		print ">"
		guess = STDIN.gets
		
		same = s(guess, word);
			
		if(same == word.length)
			puts "You won with " + (lives==0? "1" : lives.to_s) + " live" + ((lives==1||lives==0)? "" : "s") + " left!"
			exit
		end
		
		if(lives == 0) 
			puts "You lost, the word was " + word + "!"
			exit
		else
			if(mode == 0)
				puts "You got " + same.to_s + "/" + (word.size).to_s + " correct, and you have " + lives.to_s + " lives left!"
			else 
				out = ""
				
				i = 0
				
				for char in word.split("") do 
					if(!guess[i]) 
						out += " _ "
					else 
						out += (guess[i] == char ? " " + char + " " : " _ ")
					end
					i += 1
				end
				puts "You got " + same.to_s + "/" + (word.size).to_s + " correct, and you have " + lives.to_s + " lives left!"
				puts out
			end 
			
			lives -= 1
		end
	end
else 
	puts "The computer is attempting to solve it."
	while true 
		if(lives == 0)
			puts "The computer lost. The word was " + word 
			exit
		end
		
		letterWords = words.each_index.select{|i| words[i].size == s+1};
		rw = words[letterWords.sample].chomp 
		
		if(rword == false)
			wrds = []
			
			matchingSize = matchingLength(matching)
			
			for wrd in letterWords do
				c = 0
				h = 0
				for ind in matching do 
					if(ind != ".") 
						if(words[wrd][h] == ind) then c+=1 end 
					end
					h+=1
				end
				if(c==matchingSize) then wrds.push(wrd) end
			end
			rw = words[wrds.sample].chomp
		end
		
		puts "The computer guessed " + rw + "."
		
		i = 0
		for ch in rw.split("") do
			if(word[i] == ch) 
				matching[i] = ch 
				rword = false 
			else 
				if(matching[i] == nil) then matching[i] = "." end
			end
			i += 1
		end
		
		if(matchingLength(matching) == word.size) 
			puts "The computer solved the word " + word + " with " + lives.to_s + " live" + ((lives==1||lives==0)? "" : "s") + " left!"
			exit
		end
		
		lives -= 1
	end
end
