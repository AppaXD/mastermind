system "cls"

words = File.readlines("wordslist.txt");
word = words.sample.chomp;

s = word.size

lives = 6;

mode = 0
q = 0

ARGV.each do |arg|
	if(arg == "-easy") then mode = 1 end # optional easy-mode
	if(arg == "-self") then mode = 2 end # optional self-solving 
	if(arg == "-lives") # set lives [optional]
		if(!ARGV[q+1])
			puts "You need to specify an amount of lives! e.g., `ruby mm.rb lives 8`"
			exit
		end
		
		am = ARGV[q+1].to_i-1 
		
		if(am < 0)
			puts "Make sure the amount of lives is greater than 0."
			exit
		end
		
		lives = am
	end
	if(arg == "-length") # set length
		if(!ARGV[q+1])
			puts "You need to specify a word length! e.g., `ruby mm.rb length 6`"
			exit
		end
		
		am = ARGV[q+1].to_i 
		
		if(am < 0 || am > 12)
			puts "Make sure the word length is greater than 0 and less than 13!"
			exit 
		end 
		
		wl = []
		
		for w in words 
			if(w.size == am+1) then wl.push(w) end
		end
		
		if(wl.size < 1) 
			puts "Couldn't find a " + am.to_s + " letter word in this list."
			exit
		end
		word = wl.sample.chomp
		s = am
	end
	if(arg == "-file") # set word list as local file, make sure to do this before setting -length 
		if(!ARGV[q+1])
			puts "You need to specify a local file name."
			exit 
		end
		
		if(!File.exist?(ARGV[q+1]))
			puts "That file doesn't seem to exist."
			exit
		end
		
		words = File.readlines(ARGV[q+1])
		word = words.sample.chomp
		s = word.size
	end
	q+=1
end

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
