
## 1. Create an empty file

**Command:**
```bash
touch notes.txt
Explanation: Creates an empty file named notes.txt in the current directory if it does not already exist.

2. Write first line using >
Command:

bash
echo "Line 1: This is the first line" > notes.txt
Explanation: Writes the given text to notes.txt,
overwriting any existing content in the file.

3. Append a second line using >>
Command:

bash
echo "Line 2: This line is appended" >> notes.txt
Explanation: Appends the text to the end of notes.txt without removing the existing content.

4. Append a third line using tee -a
Command:

bash
echo "Line 3: Added using tee -a" | tee -a notes.txt
Explanation: tee -a appends the input to notes.txt
and displays it on the terminal at the same time.

5. Read the full file with cat
Command:

bash
cat notes.txt
Explanation: Displays the entire contents of notes.txt to the terminal.

6. Read first 2 lines with head
Command:

bash
head -n 2 notes.txt
Explanation: Shows only the first 2 lines of notes.txt.
7. Read last 2 lines with tail
Command:

bash
tail -n 2 notes.txt
Explanation: Shows only the last 2 lines of notes.txt.

text

These commands and flow follow the instructions from the README for Day 06 (create `notes.txt`, use `>`, `>>`, `cat`, `head`, `tail`, `tee`, keep it short).[1]

## 2. Run commands locally (optional but recommended)
In your cloned fork, from inside `2026/day-06/`:

```bash
touch notes.txt
echo "Line 1: This is the first line" > notes.txt
echo "Line 2: This line is appended" >> notes.txt
echo "Line 3: Added using tee -a" | tee -a notes.txt
cat notes.txt
head -n 2 notes.txt
tail -n 2 notes.txt



