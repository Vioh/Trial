import re
from docx import *

def get_header():
    print("TODO")

def is_bold(paragraph):
    # Assume that if the first 2 runs are bold
    # then the entire paragraph is bold.
    for run in paragraph.runs[:2]:
        if not run.bold: return False
    return True

def is_question(paragraph):
    text = paragraph.text.strip()
    return bool(re.match(r'^\d+[a-z]?\.', text)) and not is_bold(paragraph)

def is_answer(paragraph):
    return is_bold(paragraph)

def main():
    document = Document("data/interviews/Amir Suhonjic, PE Accounting.docx")
    paragraphs = document.paragraphs
    i, j = -1, -1

    def find_question(k):
        while k < len(paragraphs):
            if is_question(paragraphs[k]): return k
            k += 1
        return None

    def find_answer(k):
        while k < len(paragraphs):
            if is_answer(paragraphs[k]): return k
            k += 1
        return None

    while True:
        i = find_question(j+1)
        if i is None: break

        j = find_answer(i+1)
        if j is None: break

        print("===========================\n")
        print("Question: ", paragraphs[i].text, "\n")
        print("Answer: ", paragraphs[j].text, "\n")

main()
