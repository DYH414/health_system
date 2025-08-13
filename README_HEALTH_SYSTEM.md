# 健康体检管理系统

<p align="center">
	<img alt="logo" src="https://oscimg.oschina.net/oscnet/up-d3d0a9303e11d522a06cd263f3079027715.png">
</p>
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">健康体检管理系统 v1.0.0</h1>
<h4 align="center">基于若依Vue框架开发的学生健康体检管理系统</h4>

## 项目简介

健康体检管理系统是基于若依Vue框架开发的专业体检管理平台，专门针对学校、医疗机构的学生健康体检需求而设计。系统采用前后端分离架构，提供完整的体检流程管理、数据统计分析和智能提醒功能。

## 技术架构

- **前端技术栈**：Vue2 + Element UI + Axios
- **后端技术栈**：Spring Boot + Spring Security + MyBatis + Redis
- **数据库**：MySQL 5.7+
- **缓存**：Redis
- **权限认证**：JWT + RBAC
- **定时任务**：Quartz
- **代码生成**：基于若依代码生成器

## 系统特色

### 🏥 专业的体检管理
- **完整的体检流程**：从体检计划到结果复核的全流程管理
- **灵活的项目配置**：支持自定义体检项目和标准值设置
- **多级复核机制**：初审、复审、终审的严格质控流程
- **智能异常识别**：自动识别异常结果并分级管理

### 👨‍⚕️ 多角色权限管理
- **学生角色**：查看个人体检结果和历史记录
- **医务人员**：录入体检数据、进行初步审核
- **医务主管**：复核体检结果、查看统计报表
- **系统管理员**：系统配置、用户管理、数据维护

### 📊 强大的统计分析
- **实时统计面板**：体检完成率、异常率等关键指标
- **多维度报表**：按班级、时间、项目等维度统计
- **趋势分析图表**：直观展示体检数据变化趋势
- **数据导出功能**：支持Excel、PDF格式报表导出

### 🔔 智能提醒系统
- **体检提醒**：自动提醒未完成体检的学生
- **复检通知**：异常结果自动生成复检提醒
- **多种提醒方式**：系统消息、邮件、短信等多渠道通知

## 功能模块

### 1. 学生信息管理
- 学生基本信息维护
- 班级管理和分组
- 批量导入导出功能
- 学生档案查询统计

### 2. 体检项目管理
- 体检项目配置管理
- 项目分类和排序
- 正常值范围设置
- 项目状态控制

### 3. 体检结果录入
- 单个学生结果录入
- 批量数据录入
- 异常结果自动标记
- 数据校验和纠错

### 4. 体检结果复核
- 多级审核流程
- 审核意见记录
- 状态流转管理
- 复核历史追溯

### 5. 催报提醒功能
- 定时任务扫描
- 自动生成提醒
- 提醒记录管理
- 多渠道消息推送

### 6. 统计分析报表
- 体检完成率统计
- 异常情况分析
- 趋势图表展示
- 自定义报表生成

### 7. 系统管理
- 用户权限管理
- 字典数据维护
- 系统参数配置
- 操作日志审计

## 数据库设计

系统包含8个核心业务表：

| 表名 | 说明 | 主要功能 |
|------|------|----------|
| health_student | 学生信息表 | 存储学生基本信息 |
| health_check_item | 体检项目表 | 定义体检项目和标准 |
| health_check_record | 体检记录主表 | 记录体检基本信息 |
| health_check_detail | 体检明细表 | 存储具体检查结果 |
| health_check_review | 体检复核记录表 | 管理复核流程 |
| health_check_reminder | 体检提醒记录表 | 提醒消息管理 |
| health_check_statistics | 体检统计汇总表 | 缓存统计数据 |
| health_check_batch | 体检批次管理表 | 体检活动管理 |

详细的数据库设计文档请参考：[数据库设计文档](doc/health_database_design.md)

## 项目结构

```
health_system/
├── doc/                           # 项目文档
│   ├── health_database_design.md # 数据库设计文档
│   └── database_init_summary.md  # 数据库初始化总结
├── sql/                           # SQL脚本
│   ├── health_system.sql         # 健康体检系统数据库脚本
│   ├── ry_20250522.sql           # 若依基础数据脚本
│   └── quartz.sql                # 定时任务脚本
├── ruoyi-admin/                   # 后端主模块
├── ruoyi-common/                  # 通用模块
├── ruoyi-framework/               # 框架核心
├── ruoyi-generator/               # 代码生成器
├── ruoyi-quartz/                  # 定时任务
├── ruoyi-system/                  # 系统模块
├── ruoyi-ui/                      # 前端Vue项目
├── bin/                           # 部署脚本
├── pom.xml                        # Maven主配置
└── README.md                      # 项目说明
```

## 快速开始

### 环境要求

- **JDK**：1.8+
- **MySQL**：5.7+
- **Redis**：3.2+
- **Node.js**：12+
- **npm**：6+

### 安装步骤

#### 1. 克隆项目
```bash
git clone https://github.com/DYH414/health_system.git
cd health_system
```

#### 2. 数据库初始化
```sql
-- 1. 创建数据库
CREATE DATABASE ruoyi DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 2. 导入基础数据
mysql -u root -p ruoyi < sql/ry_20250522.sql

-- 3. 导入定时任务数据
mysql -u root -p ruoyi < sql/quartz.sql

-- 4. 导入健康体检系统数据
mysql -u root -p ruoyi < sql/health_system.sql
```

#### 3. 后端配置
```bash
# 1. 修改数据库配置
vim ruoyi-admin/src/main/resources/application-druid.yml

# 2. 修改Redis配置
vim ruoyi-admin/src/main/resources/application.yml

# 3. 编译项目
mvn clean compile

# 4. 启动后端服务
mvn spring-boot:run
```

#### 4. 前端配置
```bash
# 1. 进入前端目录
cd ruoyi-ui

# 2. 安装依赖
npm install

# 3. 启动前端服务
npm run dev
```

#### 5. 访问系统
- **前端地址**：http://localhost:80
- **后端地址**：http://localhost:8080
- **默认账号**：admin/admin123

## 部署说明

### Docker部署

```bash
# 1. 构建镜像
docker build -t health-system .

# 2. 运行容器
docker-compose up -d
```

### 生产环境部署

```bash
# 1. 后端打包
mvn clean package

# 2. 前端打包
cd ruoyi-ui
npm run build:prod

# 3. 部署到服务器
# 将dist目录部署到Nginx
# 将jar包部署到应用服务器
```

## 开发指南

### 代码生成

1. 访问系统管理 -> 代码生成
2. 导入数据表
3. 配置生成参数
4. 生成并下载代码
5. 将代码集成到项目中

### 自定义开发

1. **新增业务模块**
   - 在ruoyi-system中创建相应的domain、mapper、service
   - 在ruoyi-admin中创建controller
   - 在ruoyi-ui中创建前端页面

2. **权限配置**
   - 在sys_menu表中添加菜单
   - 配置权限标识
   - 在前端页面使用v-hasPermi指令

3. **数据字典**
   - 在sys_dict_type中添加字典类型
   - 在sys_dict_data中添加字典数据
   - 在前端使用dict组件

## 系统截图

### 登录页面
![登录页面](https://oscimg.oschina.net/oscnet/cd1f90be5f2684f4560c9519c0f2a232ee8.jpg)

### 系统首页
![系统首页](https://oscimg.oschina.net/oscnet/1cbcf0e6f257c7d3a063c0e3f2ff989e4b3.jpg)

### 体检管理
![体检管理](https://oscimg.oschina.net/oscnet/up-8074972883b5ba0622e13246738ebba237a.png)

### 统计报表
![统计报表](https://oscimg.oschina.net/oscnet/up-9f88719cdfca9af2e58b352a20e23d43b12.png)

## 更新日志

### v1.0.0 (2024-01-01)
- ✨ 完整的健康体检管理系统
- ✨ 基于若依Vue框架的前后端分离架构
- ✨ 8个核心业务表的完整数据库设计
- ✨ 多角色权限管理系统
- ✨ 智能提醒和统计分析功能
- ✨ 完善的文档和部署指南

## 技术支持

### 问题反馈
如果您在使用过程中遇到问题，请通过以下方式联系我们：

- **GitHub Issues**：[提交问题](https://github.com/DYH414/health_system/issues)
- **邮箱支持**：developer@healthsystem.com

### 参与贡献
欢迎参与项目贡献：

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

### 开源协议
本项目基于 MIT 协议开源，详情请参阅 [LICENSE](LICENSE) 文件。

### 致谢
- 感谢 [若依框架](https://gitee.com/y_project/RuoYi-Vue) 提供的优秀基础架构
- 感谢所有参与项目开发和测试的贡献者

---

## 联系方式

- **项目地址**：https://github.com/DYH414/health_system
- **演示地址**：http://health.demo.com（待部署）
- **技术文档**：详见doc目录
- **API文档**：启动项目后访问 http://localhost:8080/swagger-ui.html

**如果这个项目对您有帮助，请给个 ⭐ Star 支持一下！** 