# Zotero PDF2ZH Docker

这是一个用于运行 Zotero PDF2ZH 翻译服务的 Docker 镜像。该服务可以将 PDF 文件中的英文翻译成中文。

## 功能特点

- 支持 PDF 文件的英文到中文翻译
- 支持多种翻译引擎（默认为 Bing）
- 支持双栏 PDF 文件的切割和对比
- 可通过环境变量自定义配置

## 使用方法

### 构建镜像

```bash
docker build -t zotero-pdf2zh .
```

### 运行容器

```bash
docker run -d -p 8888:8888 --name pdf2zh zotero-pdf2zh
```

### 使用自定义配置运行

```bash
docker run -d -p 8888:8888 \
  -e PORT_NUM=8888 \
  -e THREAD_NUM=8 \
  -e TRANSLATE_SERVICE=bing \
  -e TRANSLATED_DIR=/app/translated/ \
  -e CONFIG_PATH=/app/config.json \
  -e PDF2ZH_CONFIG_CONTENT='{"service":"bing","thread_num":8,"proxy":""}' \
  -v /path/to/your/fonts:/app/fonts \
  -v /path/to/your/translated:/app/translated \
  --name pdf2zh zotero-pdf2zh
```

## 环境变量配置

| 环境变量              | 描述                               | 默认值           |
| --------------------- | ---------------------------------- | ---------------- |
| PORT_NUM              | 服务端口号                         | 8888             |
| PDF2ZH_CMD            | PDF2ZH 命令                        | pdf2zh           |
| THREAD_NUM            | 翻译线程数                         | 4                |
| TRANSLATE_SERVICE     | 翻译服务（bing, google, deepl 等） | bing             |
| TRANSLATED_DIR        | 翻译文件输出目录                   | /app/translated/ |
| CONFIG_PATH           | 配置文件路径                       | /app/config.json |
| PDF2ZH_CONFIG_CONTENT | PDF2ZH 配置内容（JSON 格式字符串） | 无               |

## 卷挂载

- `/app/fonts`: 字体文件目录
- `/app/translated`: 翻译输出目录

更多配置选项请参考[PDFMathTranslate 高级配置文档](https://github.com/Byaidu/PDFMathTranslate/blob/main/docs/ADVANCED.md#cofig)。

## API 接口

- `/translate`: 翻译 PDF 文件
- `/cut`: 切割双栏 PDF 文件
- `/cut-compare`: 生成中英对照文件
- `/translatedFile/<filename>`: 下载翻译后的文件

## 注意事项

- 如需使用自定义字体，请将字体文件挂载到容器的`/app/fonts`目录
- 翻译后的文件将保存在`/app/translated`目录中
