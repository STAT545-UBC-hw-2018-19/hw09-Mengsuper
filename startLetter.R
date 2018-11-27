library(tidyverse)

words <- readLines("./data/words.txt")

# create a dictionary (key: letter, value: the counts of word starting with this letter)_
dict <- rep(0, length(letters))
names(dict) <- letters

for (word in words) {
	letter <- str_to_lower(str_sub(word, start = 1, end = 1))
	dict[letter] <- dict[letter] + 1
}

lettersTable <- data.frame(letter = names(dict), freq = dict)

startLetter <- lettersTable %>%
	mutate(letter = fct_reorder(letter, freq)) %>%
	ggplot(aes(x = letter, y = freq)) +
	geom_bar(fill="blue", stat = "identity") +
	xlab("Starting letter") +
	ylab("Number of words") + 
	ggtitle("Word frequency") + 
	theme_bw() + 
	theme(plot.title = element_text(hjust = 0.5)) 

ggsave(filename = "./plots/startLetter.png", plot = startLetter)