for %%c in (ar,en,ja,ko,th,vi) do (
	..\Tools\CodeCorpus.exe merge Corpus.txt Corpus.%%c.txt diff.txt diff.%%c.txt dic.txt dic.%%c.txt
)

del Corpus.*
rename dic.* Corpus.*
pause