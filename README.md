# Trenscoda
Trenscoda is AI Program using ChatGPT written in Python or Ruby  with the ability to automatically translate a programming code from a specific language to another language (i.e. a code from python to ruby and viceversa). 

## Requirements
* Ruby 3.2.0 or Python 3

## Ruby Dependencies
* openai
* json
* fileutils
* open3
* colored
* diffy
* thor

## Python Dependencies
* openai
* sys
* json
* shutil
* subprocess
* unified_diff

## Installation
1. Clone the repository:
`git clone https://github.com/papayalabs/trenscoda.git`
2. Navigate to the project directory:
`cd trenscoda`

3. Install the required gems
`gem install ruby-openai dotenv json fileutils open3 colored diffy thor`

   Install the required libs
`pip3 install openai json shutil subprocess unified_diff`

4. Set up your OpenAI API key:
Create a file called openai_key.txt in the project directory, and paste your OpenAI API key into it.

## Usage

To use Trenscoda, simply run it with the name of the file you'd like to transform, followed by any required arguments of the language of the file and the language you want to convert to. Trenscoda will automatically transform the code of file to the another  using GPT-3.5. 

```bash
ruby trenscoda.rb <file_name> <language1> <language2>
```
In this repository we have the filename "balance.rb" that was generated with AI with this prompt: 

Please write a program in ruby code that get an ethereum address from the prompt and get the price in USD dollars of the ethereum from the coingecko api and get the quantity of ethereum contained in that address with an api then calculate the balance with this quantity and the price in USD dollars.

## Example

```bash
ruby trenscoda.rb balance.rb ruby python
```

## Limitations
Trenscoda's capabilities are impressive, but they're not infallible. In some cases, Trenscoda may be unable to convert sucessfully the file. Additionally, Trenscoda may not be able to handle complex or highly specialized codebases with the same level of accuracy as simpler scripts.

## Contributing
We welcome contributions to Trenscoda! If you'd like to contribute, please submit a pull request or open an issue to discuss your ideas.

## License
This project is licensed under the MIT License. See the LICENSE file for more information.