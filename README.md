# Equation Studio Website

Equation Studio (方程工坊) 的 GitHub Pages 静态官网。

## 目录规划（可扩展）

该结构用于避免未来新增隐私政策、服务条款、文档、博客页时反复调整。

```text
.
├── index.html                 # 官网首页（Landing）
├── robots.txt                 # 搜索引擎抓取规则
├── sitemap.xml                # 站点地图
├── assets/
│   ├── css/
│   │   ├── styles.css         # 首页样式
│   │   └── page.css           # 子页面通用样式（法律、文档等）
│   ├── js/
│   │   └── main.js            # 首页交互与中英切换
│   └── img/
│       └── logo.png           # 品牌资源
├── scripts/
│   ├── sitemap.config.json    # 页面清单与优先级配置
│   └── generate-sitemap.ps1   # sitemap 自动生成脚本
└── pages/
	├── legal/
	│   ├── privacy-policy.html
	│   └── terms-of-service.html
	├── docs/
	│   └── index.html
	├── blog/
	│   └── index.html
	└── changelog/
		└── index.html
```

## 页面扩展规则

1. 新增法律页：统一放到 `pages/legal/`
2. 新增文档页：统一放到 `pages/docs/`
3. 新增营销专题页：建议放到 `pages/marketing/`
4. 资源文件不要放根目录，统一放到 `assets/`
5. 每次新增公开页面后，同步更新 `sitemap.xml`

推荐：不直接手改 `sitemap.xml`，而是更新 `scripts/sitemap.config.json` 后执行脚本自动生成。

## 新增页面操作模板

1. 在 `pages/<category>/` 新建 `.html`
2. 引用样式：`../../assets/css/page.css`
3. 顶部返回链接统一指向：`../../index.html`
4. 在首页 footer 增加入口（如有必要）
5. 在 `sitemap.xml` 添加对应 `<url>` 节点

如果使用自动化方式：

1. 在 `scripts/sitemap.config.json` 的 `pages` 数组中新增一条
2. 运行下面命令生成 `sitemap.xml`

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\generate-sitemap.ps1
```

## 本地预览

推荐使用本地静态服务器：

```bash
python -m http.server 8080
```

打开：`http://localhost:8080`

## GitHub Pages 发布

1. 推送仓库到 GitHub
2. 仓库 Settings -> Pages
3. Source 选择 `Deploy from a branch`
4. Branch 选择 `main`，Folder 选择 `/ (root)`
5. 保存并等待部署完成

## 上线后必须替换的占位 URL

将以下文件中的 `https://example.github.io/EquationStudio/` 替换为真实地址：

- `index.html`（canonical、og:url）
- `robots.txt`（Sitemap）
- `sitemap.xml`（loc）

目标格式：

`https://<your-username>.github.io/<repo-name>/`
