# 健康体检管理系统数据库设计文档

## 概述

本文档描述了基于若依框架开发的健康体检管理系统的数据库设计，包括表结构、字段定义、索引策略和数据关系。

## 设计原则

1. **遵循若依规范**：所有表都包含BaseEntity的标准字段（create_by、create_time、update_by、update_time、remark）
2. **数据完整性**：通过外键约束和触发器保证数据一致性
3. **查询优化**：合理设计索引，提供视图和存储过程优化常用查询
4. **扩展性**：预留扩展字段，支持业务功能的后续增强

## 核心数据表

### 1. 学生信息表 (health_student)

**表名**：`health_student`  
**用途**：存储学生的基本信息，是体检系统的核心主体

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| student_id | bigint(20) | PK, AUTO_INCREMENT | 学生ID，主键 |
| user_id | bigint(20) | NULL | 关联系统用户ID，用于登录 |
| student_no | varchar(20) | UNIQUE, NOT NULL | 学号，唯一标识 |
| student_name | varchar(50) | NOT NULL | 学生姓名 |
| gender | char(1) | DEFAULT '0' | 性别（0男 1女 2未知） |
| birth_date | date | NULL | 出生日期 |
| age | int(3) | NULL | 年龄 |
| class_id | bigint(20) | NULL | 班级ID（关联部门表） |
| class_name | varchar(50) | DEFAULT '' | 班级名称 |
| grade | varchar(20) | DEFAULT '' | 年级 |
| id_card | varchar(18) | DEFAULT '' | 身份证号 |
| phone | varchar(11) | DEFAULT '' | 联系电话 |
| emergency_contact | varchar(50) | DEFAULT '' | 紧急联系人 |
| emergency_phone | varchar(11) | DEFAULT '' | 紧急联系电话 |
| address | varchar(200) | DEFAULT '' | 家庭住址 |

**索引设计**：
- `uk_student_no`：学号唯一索引
- `idx_class_id`：班级ID索引，支持按班级查询
- `idx_student_name`：姓名索引，支持姓名模糊查询
- `idx_id_card`：身份证号索引

### 2. 体检项目表 (health_check_item)

**表名**：`health_check_item`  
**用途**：定义体检项目的基础信息和标准

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| item_id | bigint(20) | PK, AUTO_INCREMENT | 项目ID，主键 |
| item_code | varchar(20) | UNIQUE, NOT NULL | 项目编码 |
| item_name | varchar(100) | NOT NULL | 项目名称 |
| item_category | varchar(50) | DEFAULT '' | 项目分类 |
| check_part | varchar(100) | DEFAULT '' | 检查部位 |
| normal_range | varchar(200) | DEFAULT '' | 正常值范围 |
| unit | varchar(20) | DEFAULT '' | 单位 |
| reference_value | varchar(100) | DEFAULT '' | 参考值 |
| order_num | int(4) | DEFAULT 0 | 显示顺序 |
| is_required | char(1) | DEFAULT '1' | 是否必检（1是 0否） |

**索引设计**：
- `uk_item_code`：项目编码唯一索引
- `idx_item_category`：项目分类索引
- `idx_order_num`：显示顺序索引

### 3. 体检记录主表 (health_check_record)

**表名**：`health_check_record`  
**用途**：记录学生的体检基本信息和整体状态

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| record_id | bigint(20) | PK, AUTO_INCREMENT | 记录ID，主键 |
| batch_no | varchar(50) | NOT NULL | 体检批次号 |
| student_id | bigint(20) | NOT NULL | 学生ID |
| check_date | date | NOT NULL | 体检日期 |
| check_status | char(1) | DEFAULT '0' | 体检状态（0待检查 1已检查 2已复核 3异常 4完成） |
| total_score | decimal(5,2) | NULL | 总体评分 |
| overall_result | varchar(50) | DEFAULT '' | 总体结果 |
| abnormal_count | int(3) | DEFAULT 0 | 异常项目数 |
| recorder_id | bigint(20) | NULL | 录入人员ID |
| recorder_name | varchar(50) | DEFAULT '' | 录入人员姓名 |
| record_time | datetime | NULL | 录入时间 |
| reviewer_id | bigint(20) | NULL | 复核人员ID |
| reviewer_name | varchar(50) | DEFAULT '' | 复核人员姓名 |
| review_time | datetime | NULL | 复核时间 |
| review_opinion | varchar(500) | DEFAULT '' | 复核意见 |

**索引设计**：
- `idx_batch_no`：批次号索引
- `idx_student_id`：学生ID索引
- `idx_check_date`：体检日期索引
- `idx_check_status`：体检状态索引
- `idx_batch_student`：批次号+学生ID复合索引

### 4. 体检明细表 (health_check_detail)

**表名**：`health_check_detail`  
**用途**：记录具体体检项目的检查结果

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| detail_id | bigint(20) | PK, AUTO_INCREMENT | 明细ID，主键 |
| record_id | bigint(20) | NOT NULL | 体检记录ID |
| item_id | bigint(20) | NOT NULL | 体检项目ID |
| item_code | varchar(20) | NOT NULL | 项目编码 |
| item_name | varchar(100) | NOT NULL | 项目名称 |
| check_result | varchar(200) | DEFAULT '' | 检查结果 |
| result_value | varchar(100) | DEFAULT '' | 检查数值 |
| is_abnormal | char(1) | DEFAULT '0' | 是否异常（0正常 1异常） |
| abnormal_level | char(1) | DEFAULT '0' | 异常等级（0正常 1轻微 2中等 3严重） |
| suggestion | varchar(500) | DEFAULT '' | 建议 |
| checker_id | bigint(20) | NULL | 检查人员ID |
| checker_name | varchar(50) | DEFAULT '' | 检查人员姓名 |
| check_time | datetime | NULL | 检查时间 |

**索引设计**：
- `idx_record_id`：体检记录ID索引
- `idx_item_id`：体检项目ID索引
- `idx_is_abnormal`：异常状态索引
- `idx_record_item`：记录ID+项目ID复合索引

### 5. 体检复核记录表 (health_check_review)

**表名**：`health_check_review`  
**用途**：记录体检结果的复核流程

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| review_id | bigint(20) | PK, AUTO_INCREMENT | 复核ID，主键 |
| record_id | bigint(20) | NOT NULL | 体检记录ID |
| review_type | char(1) | DEFAULT '1' | 复核类型（1初审 2复审 3终审） |
| review_status | char(1) | DEFAULT '0' | 复核状态（0待复核 1通过 2不通过 3需重检） |
| reviewer_id | bigint(20) | NOT NULL | 复核人员ID |
| reviewer_name | varchar(50) | NOT NULL | 复核人员姓名 |
| review_time | datetime | NOT NULL | 复核时间 |
| review_opinion | varchar(1000) | DEFAULT '' | 复核意见 |
| review_result | varchar(200) | DEFAULT '' | 复核结果 |
| next_reviewer_id | bigint(20) | NULL | 下一级复核人ID |

### 6. 体检提醒记录表 (health_check_reminder)

**表名**：`health_check_reminder`  
**用途**：记录体检相关的提醒消息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| reminder_id | bigint(20) | PK, AUTO_INCREMENT | 提醒ID，主键 |
| batch_no | varchar(50) | NOT NULL | 体检批次号 |
| student_id | bigint(20) | NOT NULL | 学生ID |
| reminder_type | char(1) | DEFAULT '1' | 提醒类型（1体检提醒 2复检提醒 3结果提醒） |
| reminder_method | varchar(20) | DEFAULT 'system' | 提醒方式（system系统消息 email邮件 sms短信） |
| reminder_content | varchar(1000) | DEFAULT '' | 提醒内容 |
| send_time | datetime | NOT NULL | 发送时间 |
| send_status | char(1) | DEFAULT '0' | 发送状态（0待发送 1已发送 2发送失败） |
| read_status | char(1) | DEFAULT '0' | 阅读状态（0未读 1已读） |
| read_time | datetime | NULL | 阅读时间 |
| sender_id | bigint(20) | NULL | 发送人ID |
| sender_name | varchar(50) | DEFAULT '' | 发送人姓名 |

### 7. 体检统计汇总表 (health_check_statistics)

**表名**：`health_check_statistics`  
**用途**：存储体检数据的统计结果，提升查询性能

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| stat_id | bigint(20) | PK, AUTO_INCREMENT | 统计ID，主键 |
| stat_date | date | NOT NULL | 统计日期 |
| batch_no | varchar(50) | NOT NULL | 体检批次号 |
| class_id | bigint(20) | NULL | 班级ID |
| class_name | varchar(50) | DEFAULT '' | 班级名称 |
| total_students | int(6) | DEFAULT 0 | 应检人数 |
| checked_students | int(6) | DEFAULT 0 | 已检人数 |
| unchecked_students | int(6) | DEFAULT 0 | 未检人数 |
| abnormal_students | int(6) | DEFAULT 0 | 异常人数 |
| check_rate | decimal(5,2) | DEFAULT 0.00 | 体检率（%） |
| abnormal_rate | decimal(5,2) | DEFAULT 0.00 | 异常率（%） |
| stat_type | char(1) | DEFAULT '1' | 统计类型（1日统计 2周统计 3月统计） |

### 8. 体检批次管理表 (health_check_batch)

**表名**：`health_check_batch`  
**用途**：管理体检活动的批次信息

| 字段名 | 数据类型 | 约束 | 说明 |
|--------|----------|------|------|
| batch_id | bigint(20) | PK, AUTO_INCREMENT | 批次ID，主键 |
| batch_no | varchar(50) | UNIQUE, NOT NULL | 批次号 |
| batch_name | varchar(100) | NOT NULL | 批次名称 |
| check_type | varchar(50) | DEFAULT '常规体检' | 体检类型 |
| start_date | date | NOT NULL | 开始日期 |
| end_date | date | NOT NULL | 结束日期 |
| target_classes | varchar(500) | DEFAULT '' | 目标班级（多个用逗号分隔） |
| total_students | int(6) | DEFAULT 0 | 计划体检人数 |
| checked_students | int(6) | DEFAULT 0 | 已体检人数 |
| batch_status | char(1) | DEFAULT '0' | 批次状态（0计划中 1进行中 2已完成 3已取消） |
| organizer_id | bigint(20) | NULL | 组织者ID |
| organizer_name | varchar(50) | DEFAULT '' | 组织者姓名 |
| description | varchar(1000) | DEFAULT '' | 批次描述 |

## 数据字典扩展

### 新增字典类型

| 字典ID | 字典名称 | 字典类型 | 说明 |
|--------|----------|----------|------|
| 100 | 体检状态 | health_check_status | 体检记录状态列表 |
| 101 | 异常等级 | health_abnormal_level | 体检异常等级列表 |
| 102 | 复核状态 | health_review_status | 体检复核状态列表 |
| 103 | 提醒类型 | health_reminder_type | 体检提醒类型列表 |
| 104 | 提醒方式 | health_reminder_method | 体检提醒方式列表 |
| 105 | 体检项目分类 | health_item_category | 体检项目分类列表 |
| 106 | 批次状态 | health_batch_status | 体检批次状态列表 |

## 视图设计

### 1. 学生体检概况视图 (v_student_health_overview)

**用途**：快速查询学生的体检总体情况

```sql
CREATE OR REPLACE VIEW v_student_health_overview AS
SELECT 
    s.student_id,
    s.student_no,
    s.student_name,
    s.class_name,
    s.gender,
    s.age,
    COUNT(r.record_id) as total_checks,
    COUNT(CASE WHEN r.check_status = '4' THEN 1 END) as completed_checks,
    COUNT(CASE WHEN r.check_status = '3' THEN 1 END) as abnormal_checks,
    MAX(r.check_date) as last_check_date
FROM health_student s
LEFT JOIN health_check_record r ON s.student_id = r.student_id
WHERE s.del_flag = '0'
GROUP BY s.student_id, s.student_no, s.student_name, s.class_name, s.gender, s.age;
```

### 2. 体检项目异常统计视图 (v_item_abnormal_statistics)

**用途**：统计各体检项目的异常情况

```sql
CREATE OR REPLACE VIEW v_item_abnormal_statistics AS
SELECT 
    i.item_id,
    i.item_code,
    i.item_name,
    i.item_category,
    COUNT(d.detail_id) as total_checks,
    COUNT(CASE WHEN d.is_abnormal = '1' THEN 1 END) as abnormal_count,
    ROUND(COUNT(CASE WHEN d.is_abnormal = '1' THEN 1 END) * 100.0 / COUNT(d.detail_id), 2) as abnormal_rate
FROM health_check_item i
LEFT JOIN health_check_detail d ON i.item_id = d.item_id AND d.del_flag = '0'
WHERE i.del_flag = '0'
GROUP BY i.item_id, i.item_code, i.item_name, i.item_category;
```

## 存储过程

### 体检数据统计存储过程 (sp_update_health_statistics)

**用途**：定期更新体检统计数据

```sql
DELIMITER $$
CREATE PROCEDURE sp_update_health_statistics(IN p_batch_no VARCHAR(50))
BEGIN
    -- 按班级统计体检数据
    -- 详细实现见SQL脚本
END$$
DELIMITER ;
```

## 触发器设计

### 1. 体检记录状态变更触发器

**触发器名**：`tr_health_record_status_change`  
**用途**：当体检状态变为异常时，自动更新异常项目数

### 2. 体检明细异常状态变更触发器

**触发器名**：`tr_health_detail_abnormal_change`  
**用途**：当明细异常状态变更时，更新主记录的异常项目数和状态

## 数据关系图

```
health_student (学生信息表)
    ↓ 1:N
health_check_record (体检记录主表)
    ↓ 1:N
health_check_detail (体检明细表)
    ↑ N:1
health_check_item (体检项目表)

health_check_record
    ↓ 1:N
health_check_review (体检复核记录表)

health_check_batch (体检批次管理表)
    ↓ 1:N
health_check_record

health_student
    ↓ 1:N
health_check_reminder (体检提醒记录表)
```

## 性能优化策略

### 1. 索引优化
- 为常用查询字段建立单列索引
- 为复合查询条件建立复合索引
- 定期分析索引使用情况，优化索引策略

### 2. 查询优化
- 使用视图简化复杂查询
- 使用存储过程处理复杂业务逻辑
- 合理使用分页查询，避免大数据量查询

### 3. 数据归档
- 定期归档历史数据
- 保持活跃数据表的合理大小
- 建立数据清理策略

## 数据安全

### 1. 敏感数据保护
- 身份证号等敏感信息加密存储
- 定期备份重要数据
- 建立数据访问审计机制

### 2. 权限控制
- 基于角色的数据访问控制
- 敏感操作记录日志
- 定期检查数据权限分配

## 维护建议

### 1. 定期维护
- 定期更新统计数据
- 清理过期的提醒记录
- 优化数据库性能

### 2. 监控指标
- 监控表大小增长趋势
- 监控查询性能
- 监控数据完整性

## 扩展计划

### 1. 功能扩展
- 支持更多体检项目类型
- 增加体检报告模板
- 集成第三方体检设备

### 2. 技术扩展
- 考虑数据分库分表
- 引入缓存机制
- 优化大数据量处理能力 