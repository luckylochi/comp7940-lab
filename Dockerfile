# 1. 使用轻量级的 Python 3.12 镜像作为基础
FROM python:3.12-slim

# 2. 设置工作目录
WORKDIR /Cloud_computing_groupwork


# 3. 【关键优化】先复制依赖文件
# Docker 会检查 requirements.txt 的变化。如果它没变，pip install 就会用缓存，构建极快。
# 如果它变了，Docker 才会重新运行 pip install。
COPY requirements.txt .

# 4. 安装依赖
# --no-cache-dir 减小镜像体积
RUN pip install --no-cache-dir -r requirements.txt

# 5. 复制其余所有代码文件
# 这一步放在最后，因为代码经常变，放在前面会导致每次改代码都重新安装依赖
COPY . .

# 6. 设置环境变量 (可选，防止 Python 生成 .pyc 文件，保持容器整洁)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 7. 启动命令
# 请根据你的主程序文件名修改下面的 chatbot.py
# 如果是 Streamlit 项目，请使用: CMD ["streamlit", "run", "chatbot.py"]
# 如果是普通 Python 脚本，请使用: CMD ["python", "chatbot.py"]
CMD ["python", "chatbot.py"]