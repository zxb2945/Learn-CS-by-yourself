# Python学习笔记

## 基本概念

### 如何新建项目

1. Install Virtual Environment

First, create a virtual environment by running the following command:

```bash
#如果在window环境下并且存在多个python解释器，建议用 py -m 代替 python -m
python -m venv venv  
```

> `py -m` 与 `python -m` 的区别：
>
> `python -m` 是标准的 Python 命令行选项，用于通过 Python 解释器运行模块。`-m` 选项会让 Python 解释器将指定的模块当作脚本来执行。
>
> 使用 `python -m` 可以运行 Python 模块，并且通常会找到并执行该模块的 `__main__` 部分。如果该模块是一个包，则会寻找包内的 `__main__.py` 文件。
>
> `py` 是 **Python 启动器**（Windows 上的工具），它是为了简化在 Windows 上使用不同版本的 Python 解释器而设计的。`py -m` 和 `python -m` 的作用相似，但是它在 Windows 操作系统上提供了一些额外的便利。帮助你避免了手动管理和选择多个版本的 Python
>
> (20241112)

Activate the virtual environment:

```bash
#虚拟环境的最大好处是它将每个项目的依赖隔离开来，每个虚拟环境都有自己的独立库，因此你可以在不同的项目中使用不同版本的库而不产生冲突。
venv\Scripts\activate  
```

2. Install Required Packages

Navigate to the `src` folder and execute the following command to install the necessary packages:

```bash
cd ./src
pip install -r requirements.txt
```

3. Run the Application

Finally, run the main.py under the `src` path to get answers and enter the chatbot interaction:

```bash
python main.py
```

(2024.11.12)

### 如何生成requirements.txt

> [如何生成python项目需要的最小requirements.txt文件？](https://www.zhihu.com/question/463332914/answer/3433457082)
>
> 方法一：pip freeze方法（不推荐） =>这个方法会将目前 [pycharm](https://www.zhihu.com/search?q=pycharm&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A3433457082}) 中已下载的所有包都导入到
>
> ```
> pip freeze
> pip freeze > requirements.txt
> ```
>
> 方法二：使用第三方库[pipreqs](https://www.zhihu.com/search?q=pipreqs&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A3433457082})（推荐） => 只包含本项目用到的库。
>
> ```shell
> pip install pipreqs
> pipreqs ./ --encoding=utf8  --force
> #–encoding=utf8 ：为使用utf8编码
> #–force ：强制执行，当 生成目录下的requirements.txt存在时覆盖
> #. /: 在哪个文件生成requirements.txt 文件
> ```
>
> 将项目需要的库导出到 requirements.txt 文件了，可以把 `requirements.txt` 文件与项目一起分享给对方。
>
> 对方只需要`pip install -r requirements.txt` 一条命令，就可以在他们的环境中安装相同的依赖包。

（20240414）

### 如何一键启动

Windows环境下可以制作一个bat脚本，以AI Hackthon项目举例：

```bat
@echo off
REM Create and activate virtual environment
python -m venv venv
call venv\Scripts\activate

REM Navigate to the `src` folder and install required packages
cd src
pip install -r requirements.txt

REM Run the application
python main.py

pause
```

(20241112)



另外可以打包成exe文件，以OCR项目举例：

> 要将一个 Python 项目打包成可执行的 exe 文件，可以使用 PyInstaller 或者 Py2exe 等工具。下面是使用 PyInstaller 的一般步骤：
>
> 1. **安装 PyInstaller**：首先需要安装 PyInstaller。可以通过 pip 工具来安装：
>
>    ```
>    pip install pyinstaller
>    ```
>
> 2. **进入项目目录**：打开命令行界面，进入到你的 Python 项目所在的目录。
>
> 3. **运行 PyInstaller**：运行 PyInstaller，指定你的 Python 入口文件，比如 `main.py`：
>
>    ```
>    pyinstaller --onefile main.py
>    ```
>
>    这会在项目目录下生成一个 `dist` 目录，里面包含了一个可执行的 exe 文件。
>
> 4. **测试可执行文件**：进入 `dist` 目录，找到生成的 exe 文件，尝试运行它，确保它能够正确地启动并运行你的项目。
>
> 5. **优化设置（可选）**：可以通过调整 PyInstaller 的选项来优化生成的 exe 文件，比如设置图标、排除不必要的文件等等。
>
> 通过以上步骤，你就可以将你的 Python 项目打包成一个可执行的 exe 文件，并方便地在 Windows 平台上运行。

=>因为 pyinstaller 不会自动打包 qml等文件，dist生成exe文件后最好移动到上一文件层级使用！！！

(20240413)



## Package

### pip

> pip 是 Python 的包安装程序。其实，pip 就是 Python `标准库（The Python Standard Library）中的一个包`，只是这个包比较特殊，用它可以来管理 Python 标准库中其他的包。`该工具提供了对Python 包的查找、下载、安装、卸载等功能`。
>
> pip与pip3只是安装位置不一样，没有本质的区别。如果系统中同时安装了Python2和Python3，则pip默认给Python2用，pip3指定给Python3用。

=>如果你没有讲pip加入到OS的环境变量中的话，可以使用 `py -m pip install pytesseract` 来代替 `pip install pytesseract`

(20240117)

### Python 标准库

> Python 标准库（Python Standard Library）是 Python 自带的一组模块和包，它提供了大量的常用工具和功能，用于各种任务，如文件操作、系统交互、数据处理、网络编程、并发编程等。标准库的设计目标是使得 Python 开发者能够无需额外安装第三方库就能完成大多数的开发任务。
>
> 举例：
>
> `string`: 提供了处理字符串的常量和函数。
>
> `re`: 提供正则表达式支持。
>
> `os.path`: 文件路径处理工具。
>
> `datetime`: 更高层次的时间日期处理。
>
> `subprocess`: 用于启动和管理子进程。
>
> `logging`: 提供日志功能。

### subprocess 

> `subprocess` 是 Python 标准库中的一个模块，提供了创建和管理子进程的功能，允许我们启动新的进程、连接到它们的输入/输出/错误管道，并等待它们的完成。通过 `subprocess` 模块，我们可以在 Python 程序中运行外部命令或者启动其他程序，并且与这些外部进程进行交互。

```python
from subprocess import Popen, PIPE, CREATE_NEW_CONSOLE

# 启动一个新的 bash 进程，在新控制台中运行，并与它交互
command = "echo Hello, World!"
process = Popen(['bash'], stdin=PIPE, stdout=PIPE, stderr=PIPE, creationflags=CREATE_NEW_CONSOLE)

# 向 bash 进程发送命令并获取输出
stdout, stderr = process.communicate(command.encode())

# 打印输出
print(stdout.decode())  # 输出: Hello, World!
```

=>我看到Harry曾经尝试用 subprocess 模块来执行cygwin命令行登录BBU并执行Moshell脚本，但因为想要随时显现 脚本执行结果 而不是等执行完后一次性显现，最终采用了写入命令到bat脚本并使用 `os.startfile()`来执行bat脚本的方式。

### Selenium 

> **Selenium** 是一个非常流行的 Python 库，用于自动化 Web 浏览器的操作，通常用于自动化测试和网页爬取。使用 **Selenium**，我们可以模拟用户在浏览器中的所有操作，比如点击按钮、填写表单、导航页面等。Selenium 支持多种编程语言，其中 Python 是最常用的语言之一。

```python
from selenium import webdriver
from selenium.webdriver.edge.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.edge.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from path_constants import PROGRAM_DIR

def get_15_day_weather_forecast(city_code):
    # 设置 Edge 选项
    edge_options = Options()
    # edge_options.add_argument("--headless") 
    edge_options.add_argument("--disable-gpu")  # 禁用 GPU 加速
    edge_options.add_argument("--no-sandbox")  # 解决DevToolsActivePort文件不存在的错误

    # 指定 Edge WebDriver 的路径
    edge_driver_path = PROGRAM_DIR / "tool/msedgedriver.exe"  # 替换为你的 Edge WebDriver 路径
    service = Service(edge_driver_path)
    driver = webdriver.Edge(service=service, options=edge_options)

    # 目标 URL
    url = f"https://m.weather.com.cn/mweather15d/{city_code}.shtml"
    driver.get(url)

    try:
        # 使用显式等待，直到天气信息元素可见
        WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.CLASS_NAME, 'h15li'))
        )

        # 查找未来15天的天气信息
        forecast_items = driver.find_elements(By.CLASS_NAME, 'h15li')

        for item in forecast_items:
            date = item.find_element(By.CLASS_NAME, 'h15listday').text.strip()
            date_full = item.find_element(By.CLASS_NAME, 'h15listdayp2').text.strip()
            weather = item.find_element(By.XPATH, ".//p[not(@class='h15listday') and not(@class='h15listdayp2')]").text.strip()
            temperature = item.find_element(By.CLASS_NAME, 'h15listtem').text.strip()

            print(f"{date} ({date_full}): {weather}, {temperature}")
    except Exception as e:
        print(f"获取天气信息时出错: {e}")
    finally:
        driver.quit()

# 获取广州的15天天气预报
get_15_day_weather_forecast("101280101")  # 广州的城市代码
```

=>Chrome或Edge的driver你需要事先下好。

（2024.11.13）

### PyQt

- PyQt是基于Qt框架的Python绑定，提供了强大的GUI开发功能。它有很好的文档和社区支持，可以创建现代、漂亮的界面。

```
pip install PyQt5
```

(20240223)

### **LangChain** 

> **LangChain** 是一个开源框架，旨在帮助开发者使用语言模型（如 GPT-3、GPT-4、其他大型语言模型）构建复杂的应用程序。它提供了一些强大的工具，帮助用户更高效地构建和集成与自然语言处理（NLP）相关的应用。

以AI Hackthon项目举例：

rag_ingestion.py:

```python
import os
from typing import Any, Dict
from langchain.schema import Document as ldoc
from dotenv import load_dotenv
from langchain_community.vectorstores import FAISS
from langchain_text_splitters import CharacterTextSplitter
from langchain_openai import AzureOpenAIEmbeddings
from langchain_community.document_loaders import TextLoader, PyPDFLoader,Docx2txtLoader,UnstructuredExcelLoader,UnstructuredPowerPointLoader
from get_q10_info import get_real_workdays
from path_constants import QUESTIONS_MATERIAL_DIR

def read_documents(path):
    if path.endswith('.txt'):
        loader = TextLoader(path, encoding='utf-8')
    elif path.endswith('.pdf'):
        loader = PyPDFLoader(path)
    elif path.endswith('.docx'):
        loader = Docx2txtLoader(path)
    elif path.endswith('.xlsx'):
        loader = UnstructuredExcelLoader(path)
    elif path.endswith('.pptx'):
        loader = UnstructuredPowerPointLoader(path)        
    else:
        print(f"Unsupported file format: {path}")
        return None
    
    documents = loader.load()
    # 将文件名或其他元数据添加到文档
    for doc in documents:
        doc.metadata['source_filename'] = os.path.basename(path)    # 记录文件名作为来源
    
    return documents

class DictLoader:
    def __init__(self, data):
        self.data = data

    def load(self):
        return [ldoc(page_content=self.data)]

def ingest_documents(questionNo):
    directory = os.path.join(QUESTIONS_MATERIAL_DIR,f"Question {questionNo}")
    print("\n\n*************************")
    print(f"Ingesting Question {questionNo}...")
    print("*************************\n\n")
    texts = []

    # 检查目录是否存在
    if not os.path.exists(directory):
        print(f"Directory does not exist: {directory}")
        return  # 直接返回，结束函数执行

    print(f"Directory exists: {directory}")

    # 遍历目录及子目录
    for root, _, files in os.walk(directory):
        print(f"Searching in: {root}")
        for file in files:
            file_path = os.path.join(root, file)
            try:
                document = read_documents(file_path)
                if document:  # 只在读取成功时添加文本
                    texts.extend(document)
                    print(f"Loaded: {file_path}")
            except Exception as e:
                print(f"Error reading {file_path}: {e}")
    if questionNo == 10:
        realworkdays = get_real_workdays()
        dictdocument = DictLoader(realworkdays)
        texts.extend(dictdocument.load())

    print("Splitting...")
    text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
    chunks = text_splitter.split_documents(texts)
    print(f"Created {len(chunks)} chunks")

    embeddings = AzureOpenAIEmbeddings(
        model=os.environ["OPENAI_MODEL_NAME_EMBEDDING"],
        azure_endpoint=os.environ["AZURE_OPENAI_ENDPOINT"],
        api_key=os.environ["AZURE_OPENAI_API_KEY"],
        openai_api_version=os.environ["OPENAI_API_VERSION_EMBEDDING"]
    )

    print("Vector storing...")
    db = FAISS.from_documents(chunks, embeddings)
    print(f"Total vectors stored: {db.index.ntotal}")

    # Write our index to disk.
    db.save_local(f"faiss_index{questionNo}")
    print("Ingestion is finished")

if __name__ == '__main__':
    load_dotenv()  # Load environment variables from .env file
    ingest_documents(10)  
```

> **FAISS** 是一个由 Facebook AI 研究团队（现为 Meta）开发的开源库，用于高效地搜索和聚类大规模向量数据。FAISS特别适用于处理大规模的向量空间搜索任务，广泛应用于搜索引擎、推荐系统、语音识别、图像检索等场景。
>
> FAISS 本身是一个 **向量(vector)检索库**，它的核心功能是对大规模的向量数据进行索引，并能够快速查询与给定向量最相似的数据。简单来说，FAISS 负责创建一个能够存储向量的索引结构，并支持高效的搜索和相似度计算。

rag_retrieve.py:

```python
import os
from dotenv import load_dotenv
from langchain_openai import AzureChatOpenAI, AzureOpenAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain.chains import RetrievalQA
import json
from common_func import log_record,draw_mindmap,get_source_text,chatbot_assistant, writeDataTodocx, writeDataToexcel
from path_constants import LOG_DIR, Q8_FILE_PATH,Q9_FILE_PATH,Q10_FILE_PATH


def run_chatbot(qNo,qValue,log_file_name):
    print("\n\n*************************")
    print(f"Retrieving Question {qNo}...")
    print("*************************\n\n")
    
    question_no = qNo
    level = qValue["level"]
    if question_no == 8:
        question_content = qValue["question_content"]+',Output in this form +++{"manager:name": ["manager1:name", "manager2:name"],"manager1": ["employee1", "employee2"],"manager2": ["employee3"]}+++'
    elif question_no == 9:
        question_content = 'Identify Plan Cost and Acute Cost, POC separately from January to March,Output in this form +++{"Plan Cost":"value","Jan-2024": {"POC":"value", "Actual Cost":"value"},"Feb-2024": {"POC":"value", "Actual Cost":"value"},{"POC":"value", "Actual Cost":"value"}+++'
    elif question_no == 10:
        question_content = 'Project needs to complete the installation of 50 base stations within the given workdays and consider the Workload and base station location. Please assist in creating a clear and detailed project plan.'
    else: 
        question_content = qValue["question_content"]

    if qNo == 1:
        answer_result = chatbot_assistant(question_content)
        source_text = []
        source_text.append({"SourceName": "Answered by a OpenAI Azure LLM", "Text": "none"})
    else:
        embeddings = AzureOpenAIEmbeddings(
            model=os.environ["OPENAI_MODEL_NAME_EMBEDDING"],
            azure_endpoint=os.environ["AZURE_OPENAI_ENDPOINT"],
            api_key=os.environ["AZURE_OPENAI_API_KEY"],
            openai_api_version=os.environ["OPENAI_API_VERSION_EMBEDDING"],
            openai_api_type="azure",)

        global db
        db = FAISS.load_local(f"faiss_index{qNo}", embeddings, allow_dangerous_deserialization=True)

        llm = AzureChatOpenAI(
            azure_endpoint=os.environ["AZURE_OPENAI_ENDPOINT"],
            azure_deployment=os.environ["OPENAI_MODEL_NAME_LLM"],
            api_version=os.environ["OPENAI_API_VERSION_LLM"],)

        qa = RetrievalQA.from_chain_type(llm=llm, retriever=db.as_retriever())
        result = qa.invoke(question_content)  # 直接使用字符串作为输入
        answer_result = result.get('result', 'No results found')

        source_text = []
        source_text.append({"SourceName": "No relevant sources found", "Text": ""})
        source_text = get_source_text(db,question_content,level)

    output = {
                "No": question_no,  #A unique identifier for each question in the dataset.
                "QuestionContent": question_content,    #The question posed, or the task given that requires a response.
                "Level": level, #The difficulty level of the question.
                "SourceText": source_text,  #The text or context from which the question or task is derived. for L2 question, only 1 source text required, for L3-L4 questions need two or more
                "Answer": answer_result,    #The participant's response to the question or task.
                "Function_calls": None
            }
    print(json.dumps(output, ensure_ascii=False, indent=4) + '\n')

    if qNo == 8:
        draw_mindmap(answer_result,Q8_FILE_PATH)
    elif qNo == 9:
        writeDataToexcel(answer_result,Q9_FILE_PATH)
    elif qNo == 10:
        writeDataTodocx(answer_result,Q10_FILE_PATH)
    else: 
        log_record(log_file_name,output)



if __name__ == "__main__":
    load_dotenv()  # Load environment variables
    run_chatbot(10,{'question_content': 'Project needs to complete the installation of 50 base stations within the given date and consider the workload and base station location. Please assist in creating a project plan accurate to each workday', 'level': 'L4'},LOG_DIR/f"result_retrieve.log")  # Call the chatbot function
```



## Visual Studio Code

### python插件

> Visual Studio Code (VSCode) 的 Python 插件（Python extension）和 Python.exe 是两个不同的概念，它们在编程和调试环境中扮演不同的角色。
>
> 1. **Python 插件：**
>    - Python 插件是一种在 VSCode 中安装的扩展，用于提供对 Python 开发环境的集成支持。
>    - 这个插件负责为你的 Python 项目提供语法高亮、代码补全、代码导航、调试支持等功能。
>    - 它与 VSCode 的其他插件一样，通过安装和配置，可以在编辑器中为 Python 开发提供更好的体验。
> 2. **python.exe：**
>    - `python.exe` 是 Python 的解释器可执行文件，它负责执行 Python 代码。
>    - 当你在 VSCode 中运行或调试 Python 代码时，实际上是由 `python.exe` 来执行你的 Python 脚本。
>    - Python 插件与 Python 解释器之间的交互，使得你能够在 VSCode 中方便地配置和使用不同的 Python 解释器、虚拟环境等。
>
> 总体来说，Python 插件是 VSCode 的一部分，提供了用于 Python 开发的工具和功能，而 `python.exe` 是 Python 解释器的执行文件，用于实际运行和执行 Python 代码。 Python 插件与 Python 解释器之间的配合使得你可以在 VSCode 中更轻松地进行 Python 开发、调试和运行

(20240215)

### launch.json 

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": true
        }
    ]
}
```

integratedTerminal => externalTerminal

(20240116)

### 函数跳转

vscode如何回到函数跳转之前的位置？

> 在 VSCode 窗口的左上角，你可以看到两个箭头按钮：
>
> - **左箭头**：表示跳转到之前的位置。
> - **右箭头**：表示跳转到下一个位置。

### __pycache__文件夹

> pycache 文件夹是**Python 编译器在运行Python 代码时生成的一个默认的缓存目录**。 当Python 解释器在第一次执行某个模块时，会在同级目录下生成一个与模块同名的. pyc 文件。
>
> 字节码缓存在.pyc文件中，而__pycache__文件夹正是缓存.pyc地方。
>
> 设置中间代码是为了解决跨平台性。

(20240215)





## Grammar

### import

1. 引入整个模块

   ```python
   import module_name
   ###当你使用 import 导入模块时，Python 会按照以下顺序搜索模块：
   
   #1.当前目录：Python 会首先在当前运行的目录中搜索模块。
   #2.环境变量 PYTHONPATH：如果模块不在当前目录中，Python 会检查环境变量 PYTHONPATH 中指定的路径。
   #3.标准库：如果还没有找到，Python 会检查 Python 的标准库（如 math、os 等）。
   #4。第三方库：如果模块仍然没有找到，Python 会在安装的第三方库中进行搜索。
   ```

   =>相对于C语言编译器专门设定入口函数main(),Python则是严格按照自上而下的执行语句顺序执行，如同shell脚本文件，例如`import module_name`甚至可以放在函数中（只是似乎只能被执行一次）。相比C语言的头文件，Python可以用import直接执行其他文件中的执行语句。

   =>`__name__`为Python中区别运行文件的变量：如若运行当前文件，则`if __name__ == "__main__"`；若是以import的形式插入运行文件，则`if __name__ == test_lib`，即当前文件名；若不加if语句，则无论何种情况均运行。

2. 引入模块的某个部分

   ```python
   from module_name import something
   #不推荐用*导入所有内容，会导致命名冲突，降低代码可读性
   from module_name import *
   ```

> from…import *语句与import区别在于：
>
> **import** 导入模块，每次使用模块中的函数都要是定是哪个模块。
>
> **from…import \*** 导入模块，每次使用模块中的函数，直接使用函数就可以了；注因为已经知道该函数是那个模块中的了

(20240126)

### global

```python
# global关键字显示地告诉解释器global_precon为全局变量,但只在当前python文件中有效
# Python中的注释是用井号（ # ）与一个空格作为开头，注释内容将延续到这一行的结尾
global global_precon
global_precon = None
```

### None和False

> 很多时候，当我们运行if None和if False会得到相同的结果，但结果相同并不代表意义一样。
>
> 从类型层面上，False是布尔类型，而None是class 'NoneType'；从意义层面上，None表示不存在，而False表示真假。
>
> .None不等于空字符串、空列表、0，也不等同于False。

```python
# 函数参数写法多样
def test(para1: str=None, para2=False):
    print("I'm a test from def")
    print(para1)
    print(para2)
```

(2023.9)

### R + 文字串

> 在python中，字符串前的r表示raw，即这是一个raw string。raw string的意思是，此字符串中的 \n \b \r ... 等转义符号，就不进行转义了

也可以使用双斜杠

```python
image_path = "C:\\Users\\zxb29\\Desktop\\图片\\_20240213222517.jpg"
```

(20240117)

### 单引号和双引号

> 简单来说，在Python中使用单引号或双引号是没有区别的，都可以用来表示一个字符串。但是这两种通用的表达方式，除了可以简化程序员的开发，避免出错之外，还有一种好处，就是可以减少转义字符的使用，使程序看起来更简洁，更清晰。

=>意思是 双引号里可以不用转义字符使用单引号，而单引号内可以不用转义字符使用双引号

### 注释

> Python 中的注释有**单行注释**和**多行注释**。
>
> **Python 中单行注释以 \**#\** 开头**
>
> **多行注释用三个单引号或者三个双引号 将注释括起来**

```python
# 这是一个注释
'''
这是多行注释，用三个单引号
这是多行注释，用三个单引号 
这是多行注释，用三个单引号
'''
print("hello world!")
"""
这是多行注释（字符串），用三个双引号
这是多行注释（字符串），用三个双引号 
这是多行注释（字符串），用三个双引号
"""
```

### 类方法和实例方法

```python
class Demo:
    def __init__(self, name):
        self.name = name

    #普通的方法，第一个参数需要是self，它表示一个具体的实例本身。
    def fun1(self):
        print(self)
        print(self.name)
        return '---这是实例方法---'
    
    def fun2(self):
        print(self)
        print(self.name)
        return '---这是实例方法2---'    

    #如果用了staticmethod，那么类方法就不需要这个self，而将这个方法当成一个普通的函数使用。
    @staticmethod 
    def fun3():
        return '---这是静态方法---'
    

print(Demo('example').fun1())
print(Demo("abc").fun2())
print(Demo('example').fun3())
```

### pass

> 如果在开发程序时，不希望立刻编与分支内部的代码可以使用pass关键字，表示一个占位符，能够保证程序的代码结构正确！
> 程序运行时，pass关键字不会执行任何的操作！

(20240116)

### with

`with`语句的基本语法是：

```python
with expression [as variable]:
    with-block
```

其中：

- `expression`通常是一个返回上下文管理器对象的表达式，它将在`with`语句中被调用。
- `variable`是一个可选的变量名，用于引用上下文管理器对象。如果提供了`as`子句，表达式的结果将被赋给该变量。
- `with-block`是一个代码块，它包含了要执行的操作，通常与上下文相关。

`with`语句的主要优点是简化了资源管理代码，并提供了更安全的方式来处理资源，因为它确保了资源在退出代码块时被释放，即使在出现异常的情况下也是如此。

(20240326)



# Smatra_Tools 20241108

**Background**

Precon: There is a factory near Tokyo where they configure all of the settings on the BBU(BaseBandUnit) using SmatraTool(the tool will call FCTool while it's running) before they send the BBU to the NE site ,as part of final check to see if that tool was operated correctly and no errors. 

**Tool Purpose**

- A tool that fully automates the preconfiguration of BBU/RP units at subcontractor Oki-Denki's facility before they are shipped around the country to the site location for installation
- Works by automates the operation of the browser-based Auto-Integration GUI using the Selenium web testing framework, then launches a script in cygwin moshell which applies the DTs and various scripts
- In the final stage, the tools runs post-precon verification (Flashcheck for LTE/MMBB; diff-check for NR) in moshell, collects various logs in a .zip, and reports to the user if the Precon was OK, NG (parameter problem etc.) or error (Smatra problem)

**Development Language**

- Python3
  * Notable 3rd party packages:
    + Selenium Web testing framework
    + Pywin32 (for interacting with system function using the win32 API)
    + Pyautogui (for some window management functionality)
- .bat scripts 
  * for launching the tool itself and launching mos scripts in cygwin directly from windows
- .mos scripts
  * Various scripts (see additional section below for which scripts are the responsibility of the Tool team vs Script team)
  * NR uses the Netconfloader.mos, which is maintained by Komura-san (Script Team)
  * LTE/MM uses the DT_loading.mos & Preconfig_Afterlog.mos, which are only used by Smatra, and thus are the repsonsibility of the Smatra maintainer

**Inputs** 

- DT 
  * (i.e. XMLs, mos scripts, & flashcheck checklists (LTE MMBB) / Diff texts (NR) output by the DT tools)
- SW update package
- common scripts / checklists in the "tools" subdirs of 4G_Auto_Precon & 5G_Auto_Precon
- LKF 
  * (Optional, tool can be executed without LKF installation)



**AutoIntegration网页GUI(html)**

1. Software Download
2. software Installation
3. Starting on New Software
4. Applying Cofiguration
5. Node Up Notification Sent
6. Applyting Radio Configuration
7. Ready for Service

通过Laptop's SFTP Server, 输入Host，UserName，Password，Site Installation File

> SFTP（SSH File Transfer Protocol）是一种安全的文件传输协议，基于SSH（Secure Shell）协议，提供加密和安全性。它用于在网络上安全地传输文件。
>
> WinSCP是一个Windows平台上的开源SFTP和FTP客户端，提供用户友好的界面，允许用户通过SFTP、FTP、SCP等协议来传输文件。WinSCP使用SFTP作为其文件传输的一种方式，允许用户安全地上传和下载文件。

> 如果你想通过 WinSCP 连接到远程电脑，你需要确保远程电脑上有一个可以处理 SFTP 请求的 SSH 服务器。Rebex 可以用作这个 SSH 服务器的实现之一。但它并不是唯一的选择。通常情况下，常用的 SSH 服务器软件有 OpenSSH、PuTTY 等。
>
> 当你在 WinSCP 中输入远程电脑的 IP 地址、端口（通常是 22）、用户名和密码时，WinSCP 会尝试连接到远程服务器的 SSH 端口。如果该端口上运行着 Rebex 或其他 SFTP 服务器，并且认证信息正确，那么 WinSCP 就可以成功连接并进行文件传输。 
>
> =>这就是Harry在本地用WinSCP传输文件时，现在远端打开Rebex SFTP界面的原因



主要聚焦 smatra 中 怎么把文件 传到 BBU上；然后打开BBU上的GUI进行配置；最后再进入BBU进行command运行；

就是这三块解决的话，基本上这个system就可以设计出来了，对吧？

**文件传输的逻辑：**

在作业PC上打开Rebex SFTP 服务器，配置作业PC的ip以及存储DT文件的根目录，然后用selenium登录BBU上的网页，输入作业PC的ip并按下Download按钮，使DT文件从作业PC上转送到BBU。

作业PC上打开Rebex SFTP 服务器既用作 接收个人PC中通过WinSCP传来的DT文件，又用作为 BBU传送去DT文件...

所以BBU上存在html文件(https://{precon.bbu_ip}/autointegration.html)，其后端已有逻辑去用SFTP协议取得DT文件，而无需自动化工具中加入相关逻辑。

**网页操作的逻辑：**

完全依托于selenium这个库。

**执行Moshell脚本逻辑：**

我看到Harry曾经尝试用 subprocess 模块来执行cygwin命令行登录BBU并执行Moshell脚本，但因为想要随时显现 脚本执行结果 而不是等执行完后一次性显现，最终采用了写入命令到bat脚本并使用 `os.startfile()`来执行bat脚本的方式。

```bat
#启动 Cygwin 的 Bash shell, 并在新的终端窗口中运行脚本，同时将输出日志保存到文件中。
C:/cygwin64/bin/bash.exe --login -c "/usr/local/bin/moshell 192.168.1.1 'show version' | tee /tmp/log.txt"
```





