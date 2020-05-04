for a in {0..9};
do
	for b in {0..9};
	do
		for c in {0..9};
		do
			for d in {0..9};
			do
				for e in {0..9};
				do
					for f in {0..9};
					do
					echo "$a$b$c$d$e$f" >> wordlist.txt
					done
				done
			done
		done
	done
done
