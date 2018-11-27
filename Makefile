all: report.html

clean:
	rm -rf ./data ./plots histogram.tsv  report.md report.html

report.html: report.rmd histogram.tsv ./plots/histogram.png ./plots/startLetter.png ./plots/endLetter.png
	Rscript -e 'rmarkdown::render("$<")'

./plots/histogram.png: histogram.tsv
	mkdir ./plots
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r ./data/words.txt
	Rscript $<

./plots/startLetter.png: startLetter.r ./data/words.txt
	Rscript $<
	
./plots/endLetter.png: endLetter.r ./data/words.txt
	Rscript $<

./data/words.txt:
	mkdir ./data
	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "./data/words.txt", quiet = TRUE)'
