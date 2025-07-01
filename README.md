# 🌟 zksql

[TOC]

## 一、简介

**`zksql` 是一个面向电力行业应用场景的智能化SQL生成模块，集成了场景意图识别、表模式与字段语义解析、SQL 智能生成与优化、多轮问答、数据库连接与查询等全流程功能。**
 系统支持通过 API 或基于 Ollama 的本地大模型调用方式，兼容 Oracle、MySQL、SQLite、PostgreSQL 等多种数据库，具备良好的跨平台适配能力。
 支持异步流式的数据返回方式，适用于对实时性要求较高的智能问答、数据分析等电力场景。

## 二、用法

### 1、版本要求

```python
python>=3.10
```

### 2、安装包

```python
pip install zksql-0.1.0-py3-none-any.whl
```

### 3、使用示例

```python
from zksql.api.frontend import SQLFrontend

#定义对象
#config表示配置文件
sqlfrontend=SQLFrontend(config=config) 

#############1、异步终端调用############
import asyncio

async def main():
    async for item in sqlfrontend.return_process('统计不同电压等级下馈线长度'):
        print(item)
asyncio.run(main())

########2、前后端接口服务--FastAPI########
from fastapi import FastAPI, Query
from fastapi.responses import StreamingResponse

app = FastAPI()
@app.get('/api/return_process')
async def return_process(question: str = Query(...)):
    return StreamingResponse(
        sqlfrontend.return_process(question),
        media_type="text/event-stream; charset=utf-8"
    )
```

### 4、config文件配置

|      参数      |  类型   |                            示例值                            |                             含义                             |
| :------------: | :-----: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ollama_timeout |  Float  |                            240.0                             |                  ollama请求超时时间，单位秒                  |
|   keep_alive   | Boolean |                             None                             | 是否保持连接，如果设为True，可以保持与Ollama服务的HTTP连接不中断 |
|    options     |  Dict   |                              {}                              |                         ollama配置项                         |
|    num_ctx     |   Int   |                             2048                             |                        上下文窗口大小                        |
|  *model_lists  |  List   | [<br/>       {<br/>            "provider":"Ollama",<br/>            "model_name":"GeoSQL_V1:latest"            "show_name":"模型1",<br/>            "base_url":"http://localhost:11434",<br/>        },<br/>        {<br/>            "provider":"DeepSeek",<br/>            "model_name":"deepseek-chat",<br/>            "show_name":"模型2", <br/>            "base_url":"https://api.deepseek.com",<br/>            "api_key": "xxx",<br/>        },<<br />] |                           模型列表                           |
| *default_model |  Dict   | {<br/>            "provider":"Ollama",<br/>            "model_name":"GeoSQL_V1:latest"            "show_name":"模型1",<br/>            "base_url":"http://localhost:11434",<br/>        }, |                  默认模型，必须在模型列表中                  |
|  sceneMDPath   |  Path   |                      r'D:\\...\场景.md'                      |         场景的描述信息地址，精确到文件，Markdown格式         |
| sceneTablePath |  Path   |                     r'D:\\...\场景嵌入'                      |         所有场景对应的DDL信息的文件夹，精确到父目录          |

### 5、参考config

```python
config = {
    "ollama_timeout": 240.0,  
    "keep_alive": None, 
    "options": {},  
    "num_ctx": 2048, 
    #模型列表
    "model_lists":[
        {
            "provider":"Ollama",#提供商
            "model_name":"ZhiKanLLM:32b",#模型名称
            "show_name":"模型1", #展示的名字
            "base_url":"http://localhost:11434",
        },
        {
            "provider":"DeepSeek", #提供商
            "model_name":"deepseek-chat",#模型名称
            "show_name":"模型2", #展示的名字
            "base_url":"https://api.deepseek.com",
            "api_key": "xxx",
        },
        {
            "provider":"ChatGPT", #提供商
            "model_name":"gpt-3.5-turbo",#模型名称
            "show_name":"模型3", #展示的名字
            "base_url":"https://api.openai.com/v1",
            "api_key": "xxx",
        },
        {
            "provider":"QWEN", #提供商
            "model_name":"qwen-plus",#模型名称
            "show_name":"模型4", #展示的名字
            "base_url":"https://dashscope.aliyuncs.com/compatible-mode/v1",
            "api_key": "xxx",
        },
    ],
    "default_model":{
            "provider":"Ollama",#提供商
            "model_name":"ZhiKanLLM:32b",#模型名称
            "show_name":"模型1", #展示的名字
            "base_url":"http://localhost:11434",
     },
    #场景
    'sceneMDPath':r'D:\\ZK\\场景梳理\\场景.md', #场景的markdown文件地址
    'sceneTablePath':r'D:\\ZK\\场景梳理\\场景嵌入',#场景表结构信息的base path
}
```



## 三、核心方法

### 1、sqlfrontend.return_process(question)

#### 用法

- 流程问答


- 根据问题生成:1、意图智能分析与解决方案生成。2、表模式与字段智能检索。3、SQL语句智能生成


#### 参数:

|  参数名  | 类型 |      含义      |           示例值           |
| :------: | :--: | :------------: | :------------------------: |
| question | Str  | 用户输入的问题 | 统计不同电压下达到设备数量 |

#### 返回信息：
- 流式返回，每次返回一个JSON结构数据

- 返回数据格式：1-4依次返回

    1. 意图智能分析与解决方案生成。

        ```python
        #正确检索到场景
        {
            'type': 'result', #返回类型：正常返回结果
            'content':'',#返回的内容
            'current_step':'insight'  #当前步骤：意图智能分析与解决方案生成
        }
        #阶段结束
        {
            'type':'step_end',#返回类型：阶段结束
         	'current_step':'insight',  #当前步骤：意图智能分析与解决方案生成
         	'next_step':'SchemaScan',  #下一步：表模式与字段智能检索
        }
        #中断--检索不到场景，返回此信息后无后续信息返回
        {
            'type': 'interrupt'#返回类型，中断，无后续阶段
        }
        ```

    2. 表模式与字段智能检索。

        ```python
        #正确返回
        {
            'type': 'result', #返回类型：正常返回结果
            'content':'',#返回的内容
            'current_step':'SchemaScan'  #当前步骤：表模式与字段智能检索
        }
        #阶段结束
        {
            'type':'step_end',#返回类型：阶段结束
         	'current_step':'SchemaScan',  #当前步骤：表模式与字段智能检索
         	'next_step':'SQLGen',  #下一步：SQL语句智能生成
        }
        ```

    3. SQL语句智能生成

        ```python
        #正确返回
        {
            'type': 'result', #返回类型：正常返回结果
            'content':'',#返回的内容
            'current_step':'SQLGen'  #当前步骤：表模式与字段智能检索
        }
        #阶段结束
        {
            'type':'step_end',#返回类型：阶段结束
         	'current_step':'SQLGen',  #当前步骤：SQL语句智能生成
         	'next_step':'end',  #下一步：到此结束，无后续阶段
        }
        ```

    4. 结束符号

        ```python
        {
            'type': 'end' #返回类型：所有阶段返回结束，终止
        }
        ```

    5. 出错

        ```python
        {
            'type': 'error',#返回类型：出错
            'content':'' #返回的内容:错误信息
        }
        ```

### 2、sqlfrontend.return_multiRounds_process(question,current_epoch,epoch)

#### 用法

- 多轮次问答


- 根据问题生成:1、意图智能分析与解决方案生成。2、表模式与字段智能检索。3、SQL语句智能生成。4、多轮次返回


#### 参数:

|    参数名     | 类型 |      含义      |           示例值           |
| :-----------: | :--: | :------------: | :------------------------: |
|   question    | Str  | 用户输入的问题 | 统计不同电压下达到设备数量 |
| current_epoch | Int  |    当前轮次    |             1              |
|     epoch     | Int  |     总轮次     |             3              |

#### 返回信息：

- 流式返回，每次返回一个JSON结构数据

- 返回数据格式：

    当current_epoch=1时，返回信息格式如下：1-4依次返回。与return_process一致

    1. 意图智能分析与解决方案生成。

        ```python
        #正确检索到场景
        {
            'type': 'result', #返回类型：正常返回结果
            'content':'',#返回的内容
            'current_step':'insight'  #当前步骤：意图智能分析与解决方案生成
        }
        #阶段结束
        {
            'type':'step_end',#返回类型：阶段结束
         	'current_step':'insight',  #当前步骤：意图智能分析与解决方案生成
         	'next_step':'SchemaScan',  #下一步：表模式与字段智能检索
        }
        #中断--检索不到场景，返回此信息后无后续信息返回
        {
            'type': 'interrupt'#返回类型，中断，无后续阶段
        }
        ```

    2. 表模式与字段智能检索。

        ```python
        #正确返回
        {
            'type': 'result', #返回类型：正常返回结果
            'content':'',#返回的内容
            'current_step':'SchemaScan'  #当前步骤：表模式与字段智能检索
        }
        #阶段结束
        {
            'type':'step_end',#返回类型：阶段结束
         	'current_step':'SchemaScan',  #当前步骤：表模式与字段智能检索
         	'next_step':'SQLGen',  #下一步：SQL语句智能生成
        }
        ```

    3. SQL语句智能生成

        ```python
        #正确返回
        {
            'type': 'result', #返回类型：正常返回结果
            'content':'',#返回的内容
            'current_step':'SQLGen'  #当前步骤：表模式与字段智能检索
        }
        #阶段结束
        {
            'type':'step_end',#返回类型：阶段结束
         	'current_step':'SQLGen',  #当前步骤：SQL语句智能生成
         	'next_step':'end',  #下一步：到此结束，无后续阶段
        }
        ```

    4. 结束符号

        ```python
        {
            'type': 'end' #返回类型：所有阶段返回结束，终止
        }
        ```

    5. 出错

        ```python
        {
            'type': 'error',#返回类型：出错
            'content':'' #返回的内容:错误信息
        }
        ```

- 当current_epoch>1时，返回信息格式如下：依次返回

    1. 多轮次返回

        ```python
        #正确返回
        {
            'type': 'result', #返回类型：正常返回结果
            'content':'',#返回的内容
            'current_step':'SQLGen'  #当前步骤：表模式与字段智能检索
        }
        #阶段结束
        {
            'type':'step_end',#返回类型：阶段结束
         	'current_step':'SQLGen',  #当前步骤：SQL语句智能生成
         	'next_step':'end',  #下一步：到此结束，无后续阶段
        }
        ```
    
    2. 结束符号
    
        ```python
        {
            'type': 'end' #返回类型：所有阶段返回结束，终止
        }
        ```
    
    3. 出错
    
        ```python
        {
            'type': 'error',#返回类型：出错
            'content':'' #返回的内容:错误信息
        }
        ```

### 3、sqlfrontend.generate_frontend_Data(sql:str)

#### 用法

- 根据SQL查询数据库中的数据

- 前提是先调用connect_to* 函数连接数据库

#### 参数

| 参数名 | 类型 |    含义     |          示例值           |
| :----: | :--: | :---------: | :-----------------------: |
|  sql   | Str  | SQL查询语句 | SELECT * FROM DM_DEVICE_D |

#### 返回信息

- 流式返回，每次返回一个JSON结构数据

- 返回数据格式：

    1. 返回表头

        ```python
        {
            'type': 'columns',#返回类型：表头
            'columns':[] #返回的内容:数组格式，每一个值表示一个列名
        }
        ```

    2. 返回每一行数据，一次返回一行

        ```python
        {
            'type': 'row',#返回类型：一行数据
            'columns':[] #返回的内容:数组格式，每一个值表示一列的值
        }
        ```

    3. 结束符号

        ```python
        {
            'type': 'end' #返回类型：所有数据返回结束，终止
        }
        ```

### 4、sqlfrontend.connect_to_oracle(user: str ,password: str , dsn: str)

#### 用法

- 连接Oracle数据库

#### 参数

|  参数名  | 类型 |                  含义                  |       示例值        |
| :------: | :--: | :------------------------------------: | :-----------------: |
|   user   | Str  |              数据库用户名              |         lzq         |
| password | Str  |               数据库密码               |       123456        |
|   dsn    | Path | 数据库连接信息（主机名:端口号/服务名） | 127.0.0.1:1522/orcl |

#### 返回信息

- 无返回信息

### 5、sqlfrontend.connect_to_mysql(host: str,dbname: str ,user: str,password: str,port: int)

#### 用法

- 连接MySQL数据库

#### 参数

|  参数名  | 类型 |   含义   |  示例值   |
| :------: | :--: | :------: | :-------: |
|   host   | Str  |  主机名  | 127.0.0.1 |
|  dbname  | Str  | 数据库名 |   zkdb    |
|   user   | Str  |  用户名  |    lzq    |
| password | Str  |   密码   |  123456   |
|   port   | Int  |  端口号  |   3306    |

#### 返回信息

- 无返回信息

### 6、sqlfrontend.connect_to_sqlite(url: str, check_same_thread: bool)

#### 用法

- 连接SQLite数据库

#### 参数

|      参数名       |  类型   |               含义               |     示例值      |
| :---------------: | :-----: | :------------------------------: | :-------------: |
|        url        |  Path   |            数据库路径            | D:/data/test.db |
| check_same_thread | Boolean | 是否允许多线程访问同一个连接对象 |      False      |

#### 返回信息

- 无返回信息

### 7、sqlfrontend.connect_to_postgres(host: str,dbname: str ,user: str,password: str,port: int)

#### 用法

- 连接PostgreSQL 数据库

#### 参数

|  参数名  | 类型 |       含义       |  示例值   |
| :------: | :--: | :--------------: | :-------: |
|   host   | Str  | 数据库服务器地址 | 127.0.0.1 |
|  dbname  | Str  |     数据库名     |   zkdb    |
|   user   | Str  |      用户名      |    lzq    |
| password | Str  |       密码       |  123456   |
|   port   | Int  |      端口号      |   5432    |

#### 返回信息

- 无返回信息

### 8、sqlfrontend.return_figure(sql: str)

#### 用法

- 根据生成的SQL和数据返回图表

#### 参数

| 参数名 | 类型 |    含义     |          示例值           |
| :----: | :--: | :---------: | :-----------------------: |
|  sql   | Str  | SQL查询语句 | SELECT * FROM DM_DEVICE_D |

#### 返回信息

- 一个 Plotly 图表对象的字典形式

### 9、sqlfrontend.getAllModel()

#### 用法

- 获得所有LLM

#### 返回信息

- 一个 包含所有LLM名称的数组

### 10、sqlfrontend.getCurrentModel()

#### 用法

- 获得当前使用的LLM

#### 返回信息

- 返回一个字符串，表示当前LLM的名称

### 11、sqlfrontend.update_llm_model(model_name:str)

#### 用法

- 根据模型名称，更好模型
- 注意：传入的模型名称必须是已有的，在所有模型列表里的

#### 参数

|   参数名   | 类型 |   含义   |    示例值     |
| :--------: | :--: | :------: | :-----------: |
| model_name | Str  | 模型名称 | ZhiKanLLM-32b |

#### 返回信息

- 无返回信息
