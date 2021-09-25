import re
from docx import *
from glob import glob

###################################################################################

def get_header():
    print("TODO")

class MissingQuestionsException(Exception):
    pass

class QuestionNotFoundException(Exception):
    pass

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
    text = paragraph.text.strip()
    if not text:
        return True  # ignore empty string for answer only (not for question)
    return not bool(re.match(r'^[A-Z]\.', text)) and is_bold(paragraph)

def make_key(question):
    key = " ".join(question.split()[:2])
    if key == "31. Ca": return "31a. Ca"  # special handling
    return key

def parse_doc(path, question_bank=None):
    output = dict()
    document = Document(path)
    paragraphs = document.paragraphs
    i, j = -1, -1

    def find_question(k):
        while k < len(paragraphs):
            if is_question(paragraphs[k]): return k, paragraphs[k].text.strip()
            k += 1
        return k, None

    def find_answer(k):
        start, end = None, None

        while k < len(paragraphs):
            if is_answer(paragraphs[k]): start = k; break
            k += 1

        while k < len(paragraphs):
            if not is_answer(paragraphs[k]): end = k; break
            k += 1

        if start is not None and end is not None:
            answer = "\n".join([p.text for p in paragraphs[start:end]])
            return end-1, answer.strip()
        elif start is not None:
            return start, paragraphs[start].text.strip()
        else:
            return k, None

    if question_bank is not None:
        print("\n" * 5, "PARSING: " + path, "\n", sep="")

    while True:
        i, question = find_question(j+1)
        if question is None: break

        j, answer = find_answer(i+1)
        if answer is None: break

        key = make_key(question)
        if question_bank is None:
            output[key] = question
        elif key not in question_bank:
            raise QuestionNotFoundException("Not found [{}] in path [{}]".format(key, path))
        else:
            output[key] = answer
            print("===========================\n")
            print("Question: ", question, "\n", sep="")
            print("Answer: ", answer, "\n", sep="")

    if question_bank is not None:
        print("===========================\n")
        if len(output) < len(question_bank):
            raise MissingQuestionsException("Missing questions [{}] [expected:{}] [actual:{}]"
                                            .format(path, len(question_bank), len(output)))
    return output

###################################################################################

def compute_question_bank():
    bank = parse_doc("data/interviews/Copy of Axxima.docx")
    print("====================== QUESTION BANK ========================\n")
    for key, value in bank.items():
        print(key, " ==> ", value, "\n", sep="")
    print("=============================================================")
    return bank

def main():
    paths = glob("data/interviews/*.docx")
    question_bank = compute_question_bank()
    question_not_found = []
    missing_questions = []

    for path in paths:
        try:
            output = parse_doc(path, question_bank)
        except QuestionNotFoundException as e:
            question_not_found.append(path)
            print(e)
        except MissingQuestionsException as e:
            missing_questions.append(path)
            print(e)

    print("\n\n====================== MISSING QUESTIONS =========================")
    print(len(missing_questions))
    for path in missing_questions:
        print(path)
    print("====================== QUESTION NOT FOUND ========================")
    print(len(question_not_found))
    for path in question_not_found:
        print(path)
    print("==================================================================")

main()
