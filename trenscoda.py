import openai
import sys
import os
import json
import shutil
import subprocess
from difflib import unified_diff

openai.api_key = open('openai_key.txt').read().strip()

def send_code_to_gpt(script_name,language1,language2):
    with open(script_name) as f:
        code = f.read()

    file_lines = code.split('\n')
    file_with_lines = '\n'.join([f'{i+1}: {line}' for i, line in enumerate(file_lines)])

    initial_prompt_text = open('prompt.txt').read()
    prompt = build_prompt(initial_prompt_text, file_with_lines,language1,language2)

    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": prompt}],
        temperature=1.0,
    )

    output = response.choices[0].message.content
    status = response.object

    return output, status

def build_prompt(initial_prompt_text, file_with_lines,language1,language2):
    return initial_prompt_text + '\n\n' \
        f'Here is the code that needs to convert from {language1} to {language2}:\n\n' \
        f'{file_with_lines}\n\n' \
        'Please provide your suggested changes'

def main():
    if len(sys.argv) < 3:
        print('Usage: trenscoda.py <file_name> <language1> <language2> ...')
        print('Remember that file_name is written in language1')
        exit(1)

    file_name = sys.argv[1]
    language1 = sys.argv[2]
    language2 = sys.argv[3]

    while True:
        output, status = send_code_to_gpt(file_name,language1,language2)

        if status == 'chat.completion':
            print('Script ran successfully.')
            print(f'Output: {output}')
            break
        else:
            print('Script crashed. Trying to fix...')
            print(f'Output: {output}')

if __name__ == '__main__':
    main()
