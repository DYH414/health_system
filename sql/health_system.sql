-- ==============================
-- 健康体检管理系统数据库脚本
-- 基于若依框架 v3.9.0
-- 创建时间：2024年
-- ==============================

-- ----------------------------
-- 1、学生信息表
-- ----------------------------
drop table if exists health_student;
create table health_student (
  student_id        bigint(20)      not null auto_increment    comment '学生ID',
  user_id           bigint(20)      default null               comment '关联系统用户ID',
  student_no        varchar(20)     not null                   comment '学号',
  student_name      varchar(50)     not null                   comment '学生姓名',
  gender            char(1)         default '0'                comment '性别（0男 1女 2未知）',
  birth_date        date            default null               comment '出生日期',
  age               int(3)          default null               comment '年龄',
  class_id          bigint(20)      default null               comment '班级ID（关联部门表）',
  class_name        varchar(50)     default ''                 comment '班级名称',
  grade             varchar(20)     default ''                 comment '年级',
  id_card           varchar(18)     default ''                 comment '身份证号',
  phone             varchar(11)     default ''                 comment '联系电话',
  emergency_contact varchar(50)     default ''                 comment '紧急联系人',
  emergency_phone   varchar(11)     default ''                 comment '紧急联系电话',
  address           varchar(200)    default ''                 comment '家庭住址',
  status            char(1)         default '0'                comment '状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (student_id),
  unique key uk_student_no (student_no),
  key idx_class_id (class_id),
  key idx_student_name (student_name),
  key idx_id_card (id_card)
) engine=innodb auto_increment=1000 comment = '学生信息表';

-- ----------------------------
-- 2、体检项目表
-- ----------------------------
drop table if exists health_check_item;
create table health_check_item (
  item_id           bigint(20)      not null auto_increment    comment '项目ID',
  item_code         varchar(20)     not null                   comment '项目编码',
  item_name         varchar(100)    not null                   comment '项目名称',
  item_category     varchar(50)     default ''                 comment '项目分类',
  check_part        varchar(100)    default ''                 comment '检查部位',
  normal_range      varchar(200)    default ''                 comment '正常值范围',
  unit              varchar(20)     default ''                 comment '单位',
  reference_value   varchar(100)    default ''                 comment '参考值',
  order_num         int(4)          default 0                  comment '显示顺序',
  is_required       char(1)         default '1'                comment '是否必检（1是 0否）',
  status            char(1)         default '0'                comment '状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (item_id),
  unique key uk_item_code (item_code),
  key idx_item_category (item_category),
  key idx_order_num (order_num)
) engine=innodb auto_increment=100 comment = '体检项目表';

-- ----------------------------
-- 3、体检记录主表
-- ----------------------------
drop table if exists health_check_record;
create table health_check_record (
  record_id         bigint(20)      not null auto_increment    comment '记录ID',
  batch_no          varchar(50)     not null                   comment '体检批次号',
  student_id        bigint(20)      not null                   comment '学生ID',
  check_date        date            not null                   comment '体检日期',
  check_status      char(1)         default '0'                comment '体检状态（0待检查 1已检查 2已复核 3异常 4完成）',
  total_score       decimal(5,2)    default null               comment '总体评分',
  overall_result    varchar(50)     default ''                 comment '总体结果',
  abnormal_count    int(3)          default 0                  comment '异常项目数',
  recorder_id       bigint(20)      default null               comment '录入人员ID',
  recorder_name     varchar(50)     default ''                 comment '录入人员姓名',
  record_time       datetime        default null               comment '录入时间',
  reviewer_id       bigint(20)      default null               comment '复核人员ID',
  reviewer_name     varchar(50)     default ''                 comment '复核人员姓名',
  review_time       datetime        default null               comment '复核时间',
  review_opinion    varchar(500)    default ''                 comment '复核意见',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (record_id),
  key idx_batch_no (batch_no),
  key idx_student_id (student_id),
  key idx_check_date (check_date),
  key idx_check_status (check_status),
  key idx_batch_student (batch_no, student_id)
) engine=innodb auto_increment=10000 comment = '体检记录主表';

-- ----------------------------
-- 4、体检明细表
-- ----------------------------
drop table if exists health_check_detail;
create table health_check_detail (
  detail_id         bigint(20)      not null auto_increment    comment '明细ID',
  record_id         bigint(20)      not null                   comment '体检记录ID',
  item_id           bigint(20)      not null                   comment '体检项目ID',
  item_code         varchar(20)     not null                   comment '项目编码',
  item_name         varchar(100)    not null                   comment '项目名称',
  check_result      varchar(200)    default ''                 comment '检查结果',
  result_value      varchar(100)    default ''                 comment '检查数值',
  is_abnormal       char(1)         default '0'                comment '是否异常（0正常 1异常）',
  abnormal_level    char(1)         default '0'                comment '异常等级（0正常 1轻微 2中等 3严重）',
  suggestion        varchar(500)    default ''                 comment '建议',
  checker_id        bigint(20)      default null               comment '检查人员ID',
  checker_name      varchar(50)     default ''                 comment '检查人员姓名',
  check_time        datetime        default null               comment '检查时间',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (detail_id),
  key idx_record_id (record_id),
  key idx_item_id (item_id),
  key idx_is_abnormal (is_abnormal),
  key idx_record_item (record_id, item_id)
) engine=innodb auto_increment=50000 comment = '体检明细表';

-- ----------------------------
-- 5、体检复核记录表
-- ----------------------------
drop table if exists health_check_review;
create table health_check_review (
  review_id         bigint(20)      not null auto_increment    comment '复核ID',
  record_id         bigint(20)      not null                   comment '体检记录ID',
  review_type       char(1)         default '1'                comment '复核类型（1初审 2复审 3终审）',
  review_status     char(1)         default '0'                comment '复核状态（0待复核 1通过 2不通过 3需重检）',
  reviewer_id       bigint(20)      not null                   comment '复核人员ID',
  reviewer_name     varchar(50)     not null                   comment '复核人员姓名',
  review_time       datetime        not null                   comment '复核时间',
  review_opinion    varchar(1000)   default ''                 comment '复核意见',
  review_result     varchar(200)    default ''                 comment '复核结果',
  next_reviewer_id  bigint(20)      default null               comment '下一级复核人ID',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (review_id),
  key idx_record_id (record_id),
  key idx_reviewer_id (reviewer_id),
  key idx_review_time (review_time),
  key idx_review_status (review_status)
) engine=innodb auto_increment=10000 comment = '体检复核记录表';

-- ----------------------------
-- 6、体检提醒记录表
-- ----------------------------
drop table if exists health_check_reminder;
create table health_check_reminder (
  reminder_id       bigint(20)      not null auto_increment    comment '提醒ID',
  batch_no          varchar(50)     not null                   comment '体检批次号',
  student_id        bigint(20)      not null                   comment '学生ID',
  reminder_type     char(1)         default '1'                comment '提醒类型（1体检提醒 2复检提醒 3结果提醒）',
  reminder_method   varchar(20)     default 'system'           comment '提醒方式（system系统消息 email邮件 sms短信）',
  reminder_content  varchar(1000)   default ''                 comment '提醒内容',
  send_time         datetime        not null                   comment '发送时间',
  send_status       char(1)         default '0'                comment '发送状态（0待发送 1已发送 2发送失败）',
  read_status       char(1)         default '0'                comment '阅读状态（0未读 1已读）',
  read_time         datetime        default null               comment '阅读时间',
  sender_id         bigint(20)      default null               comment '发送人ID',
  sender_name       varchar(50)     default ''                 comment '发送人姓名',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (reminder_id),
  key idx_batch_no (batch_no),
  key idx_student_id (student_id),
  key idx_send_time (send_time),
  key idx_send_status (send_status)
) engine=innodb auto_increment=10000 comment = '体检提醒记录表';

-- ----------------------------
-- 7、体检统计汇总表
-- ----------------------------
drop table if exists health_check_statistics;
create table health_check_statistics (
  stat_id           bigint(20)      not null auto_increment    comment '统计ID',
  stat_date         date            not null                   comment '统计日期',
  batch_no          varchar(50)     not null                   comment '体检批次号',
  class_id          bigint(20)      default null               comment '班级ID',
  class_name        varchar(50)     default ''                 comment '班级名称',
  total_students    int(6)          default 0                  comment '应检人数',
  checked_students  int(6)          default 0                  comment '已检人数',
  unchecked_students int(6)         default 0                  comment '未检人数',
  abnormal_students int(6)          default 0                  comment '异常人数',
  check_rate        decimal(5,2)    default 0.00               comment '体检率（%）',
  abnormal_rate     decimal(5,2)    default 0.00               comment '异常率（%）',
  stat_type         char(1)         default '1'                comment '统计类型（1日统计 2周统计 3月统计）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (stat_id),
  key idx_stat_date (stat_date),
  key idx_batch_no (batch_no),
  key idx_class_id (class_id),
  key idx_stat_type (stat_type)
) engine=innodb auto_increment=1000 comment = '体检统计汇总表';

-- ----------------------------
-- 8、体检批次管理表
-- ----------------------------
drop table if exists health_check_batch;
create table health_check_batch (
  batch_id          bigint(20)      not null auto_increment    comment '批次ID',
  batch_no          varchar(50)     not null                   comment '批次号',
  batch_name        varchar(100)    not null                   comment '批次名称',
  check_type        varchar(50)     default '常规体检'          comment '体检类型',
  start_date        date            not null                   comment '开始日期',
  end_date          date            not null                   comment '结束日期',
  target_classes    varchar(500)    default ''                 comment '目标班级（多个用逗号分隔）',
  total_students    int(6)          default 0                  comment '计划体检人数',
  checked_students  int(6)          default 0                  comment '已体检人数',
  batch_status      char(1)         default '0'                comment '批次状态（0计划中 1进行中 2已完成 3已取消）',
  organizer_id      bigint(20)      default null               comment '组织者ID',
  organizer_name    varchar(50)     default ''                 comment '组织者姓名',
  description       varchar(1000)   default ''                 comment '批次描述',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (batch_id),
  unique key uk_batch_no (batch_no),
  key idx_start_date (start_date),
  key idx_batch_status (batch_status)
) engine=innodb auto_increment=100 comment = '体检批次管理表';

-- ----------------------------
-- 初始化体检项目数据
-- ----------------------------
insert into health_check_item values(1, 'HEIGHT', '身高', '基础测量', '身高', '正常范围因年龄而异', 'cm', '参考标准身高表', 1, '1', '0', '0', 'admin', sysdate(), '', null, '身高测量');
insert into health_check_item values(2, 'WEIGHT', '体重', '基础测量', '体重', '正常范围因年龄而异', 'kg', '参考标准体重表', 2, '1', '0', '0', 'admin', sysdate(), '', null, '体重测量');
insert into health_check_item values(3, 'BMI', '体重指数', '基础测量', 'BMI', '18.5-23.9', 'kg/m²', '正常范围18.5-23.9', 3, '1', '0', '0', 'admin', sysdate(), '', null, '体重指数');
insert into health_check_item values(4, 'VISION_L', '左眼视力', '视力检查', '左眼', '5.0及以上', '', '正常视力5.0', 4, '1', '0', '0', 'admin', sysdate(), '', null, '左眼视力检查');
insert into health_check_item values(5, 'VISION_R', '右眼视力', '视力检查', '右眼', '5.0及以上', '', '正常视力5.0', 5, '1', '0', '0', 'admin', sysdate(), '', null, '右眼视力检查');
insert into health_check_item values(6, 'BLOOD_PRESSURE', '血压', '生理指标', '血压', '收缩压90-140mmHg，舒张压60-90mmHg', 'mmHg', '正常血压范围', 6, '1', '0', '0', 'admin', sysdate(), '', null, '血压测量');
insert into health_check_item values(7, 'HEART_RATE', '心率', '生理指标', '心率', '60-100次/分', '次/分', '正常心率60-100', 7, '1', '0', '0', 'admin', sysdate(), '', null, '心率测量');
insert into health_check_item values(8, 'LUNG_CAPACITY', '肺活量', '肺功能', '肺部', '因年龄性别而异', 'ml', '参考肺活量标准', 8, '1', '0', '0', 'admin', sysdate(), '', null, '肺活量测试');
insert into health_check_item values(9, 'CHEST_XRAY', '胸部X光', '影像检查', '胸部', '双肺清晰，心影正常', '', '胸部X光正常', 9, '0', '0', '0', 'admin', sysdate(), '', null, '胸部X光检查');
insert into health_check_item values(10, 'BLOOD_ROUTINE', '血常规', '实验室检查', '血液', '各项指标正常', '', '血常规正常范围', 10, '0', '0', '0', 'admin', sysdate(), '', null, '血常规检查');

-- ----------------------------
-- 初始化字典类型数据（体检相关）
-- ----------------------------
insert into sys_dict_type values(100, '体检状态', 'health_check_status', '0', 'admin', sysdate(), '', null, '体检记录状态列表');
insert into sys_dict_type values(101, '异常等级', 'health_abnormal_level', '0', 'admin', sysdate(), '', null, '体检异常等级列表');
insert into sys_dict_type values(102, '复核状态', 'health_review_status', '0', 'admin', sysdate(), '', null, '体检复核状态列表');
insert into sys_dict_type values(103, '提醒类型', 'health_reminder_type', '0', 'admin', sysdate(), '', null, '体检提醒类型列表');
insert into sys_dict_type values(104, '提醒方式', 'health_reminder_method', '0', 'admin', sysdate(), '', null, '体检提醒方式列表');
insert into sys_dict_type values(105, '体检项目分类', 'health_item_category', '0', 'admin', sysdate(), '', null, '体检项目分类列表');
insert into sys_dict_type values(106, '批次状态', 'health_batch_status', '0', 'admin', sysdate(), '', null, '体检批次状态列表');

-- ----------------------------
-- 初始化字典数据（体检相关）
-- ----------------------------
-- 体检状态
insert into sys_dict_data values(1000, 1, '待检查', '0', 'health_check_status', '', 'info', 'Y', '0', 'admin', sysdate(), '', null, '待检查状态');
insert into sys_dict_data values(1001, 2, '已检查', '1', 'health_check_status', '', 'primary', 'N', '0', 'admin', sysdate(), '', null, '已检查状态');
insert into sys_dict_data values(1002, 3, '已复核', '2', 'health_check_status', '', 'success', 'N', '0', 'admin', sysdate(), '', null, '已复核状态');
insert into sys_dict_data values(1003, 4, '异常', '3', 'health_check_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '异常状态');
insert into sys_dict_data values(1004, 5, '完成', '4', 'health_check_status', '', 'success', 'N', '0', 'admin', sysdate(), '', null, '完成状态');

-- 异常等级
insert into sys_dict_data values(1005, 1, '正常', '0', 'health_abnormal_level', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '正常');
insert into sys_dict_data values(1006, 2, '轻微异常', '1', 'health_abnormal_level', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '轻微异常');
insert into sys_dict_data values(1007, 3, '中度异常', '2', 'health_abnormal_level', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '中度异常');
insert into sys_dict_data values(1008, 4, '严重异常', '3', 'health_abnormal_level', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '严重异常');

-- 复核状态
insert into sys_dict_data values(1009, 1, '待复核', '0', 'health_review_status', '', 'info', 'Y', '0', 'admin', sysdate(), '', null, '待复核');
insert into sys_dict_data values(1010, 2, '通过', '1', 'health_review_status', '', 'success', 'N', '0', 'admin', sysdate(), '', null, '复核通过');
insert into sys_dict_data values(1011, 3, '不通过', '2', 'health_review_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '复核不通过');
insert into sys_dict_data values(1012, 4, '需重检', '3', 'health_review_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '需要重检');

-- 提醒类型
insert into sys_dict_data values(1013, 1, '体检提醒', '1', 'health_reminder_type', '', 'primary', 'Y', '0', 'admin', sysdate(), '', null, '体检提醒');
insert into sys_dict_data values(1014, 2, '复检提醒', '2', 'health_reminder_type', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '复检提醒');
insert into sys_dict_data values(1015, 3, '结果提醒', '3', 'health_reminder_type', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '结果提醒');

-- 提醒方式
insert into sys_dict_data values(1016, 1, '系统消息', 'system', 'health_reminder_method', '', 'primary', 'Y', '0', 'admin', sysdate(), '', null, '系统内消息');
insert into sys_dict_data values(1017, 2, '邮件提醒', 'email', 'health_reminder_method', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '邮件提醒');
insert into sys_dict_data values(1018, 3, '短信提醒', 'sms', 'health_reminder_method', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '短信提醒');

-- 体检项目分类
insert into sys_dict_data values(1019, 1, '基础测量', '基础测量', 'health_item_category', '', 'primary', 'Y', '0', 'admin', sysdate(), '', null, '基础测量项目');
insert into sys_dict_data values(1020, 2, '视力检查', '视力检查', 'health_item_category', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '视力检查项目');
insert into sys_dict_data values(1021, 3, '生理指标', '生理指标', 'health_item_category', '', 'success', 'N', '0', 'admin', sysdate(), '', null, '生理指标检查');
insert into sys_dict_data values(1022, 4, '肺功能', '肺功能', 'health_item_category', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '肺功能检查');
insert into sys_dict_data values(1023, 5, '影像检查', '影像检查', 'health_item_category', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '影像检查项目');
insert into sys_dict_data values(1024, 6, '实验室检查', '实验室检查', 'health_item_category', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '实验室检查项目');

-- 批次状态
insert into sys_dict_data values(1025, 1, '计划中', '0', 'health_batch_status', '', 'info', 'Y', '0', 'admin', sysdate(), '', null, '计划中');
insert into sys_dict_data values(1026, 2, '进行中', '1', 'health_batch_status', '', 'primary', 'N', '0', 'admin', sysdate(), '', null, '进行中');
insert into sys_dict_data values(1027, 3, '已完成', '2', 'health_batch_status', '', 'success', 'N', '0', 'admin', sysdate(), '', null, '已完成');
insert into sys_dict_data values(1028, 4, '已取消', '3', 'health_batch_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '已取消');

-- ----------------------------
-- 初始化示例数据
-- ----------------------------
-- 体检批次示例数据
insert into health_check_batch values(1, 'BATCH202401', '2024年春季学生健康体检', '常规体检', '2024-03-01', '2024-03-31', '101,102,103', 150, 0, '0', 1, 'admin', '2024年春季学生健康体检活动', '0', 'admin', sysdate(), '', null, '春季体检批次');

-- 学生信息示例数据
insert into health_student values(1000, null, '2024001', '张三', '0', '2010-05-15', 14, 103, '一年级1班', '一年级', '110101201005150012', '13800138001', '张父', '13900139001', '北京市朝阳区', '0', '0', 'admin', sysdate(), '', null, '示例学生1');
insert into health_student values(1001, null, '2024002', '李四', '1', '2010-08-20', 14, 103, '一年级1班', '一年级', '110101201008200023', '13800138002', '李母', '13900139002', '北京市海淀区', '0', '0', 'admin', sysdate(), '', null, '示例学生2');
insert into health_student values(1002, null, '2024003', '王五', '0', '2010-12-10', 13, 104, '一年级2班', '一年级', '110101201012100034', '13800138003', '王父', '13900139003', '北京市西城区', '0', '0', 'admin', sysdate(), '', null, '示例学生3');

-- ----------------------------
-- 创建视图（统计查询优化）
-- ----------------------------
-- 学生体检概况视图
create or replace view v_student_health_overview as
select 
    s.student_id,
    s.student_no,
    s.student_name,
    s.class_name,
    s.gender,
    s.age,
    count(r.record_id) as total_checks,
    count(case when r.check_status = '4' then 1 end) as completed_checks,
    count(case when r.check_status = '3' then 1 end) as abnormal_checks,
    max(r.check_date) as last_check_date
from health_student s
left join health_check_record r on s.student_id = r.student_id
where s.del_flag = '0'
group by s.student_id, s.student_no, s.student_name, s.class_name, s.gender, s.age;

-- 体检项目异常统计视图
create or replace view v_item_abnormal_statistics as
select 
    i.item_id,
    i.item_code,
    i.item_name,
    i.item_category,
    count(d.detail_id) as total_checks,
    count(case when d.is_abnormal = '1' then 1 end) as abnormal_count,
    round(count(case when d.is_abnormal = '1' then 1 end) * 100.0 / count(d.detail_id), 2) as abnormal_rate
from health_check_item i
left join health_check_detail d on i.item_id = d.item_id and d.del_flag = '0'
where i.del_flag = '0'
group by i.item_id, i.item_code, i.item_name, i.item_category;

-- ----------------------------
-- 创建存储过程
-- ----------------------------
-- 体检数据统计存储过程
delimiter $$
create procedure sp_update_health_statistics(in p_batch_no varchar(50))
begin
    declare done int default false;
    declare v_class_id bigint(20);
    declare v_class_name varchar(50);
    declare class_cursor cursor for 
        select distinct class_id, class_name 
        from health_student 
        where del_flag = '0';
    declare continue handler for not found set done = true;
    
    -- 删除当日统计数据
    delete from health_check_statistics 
    where batch_no = p_batch_no and stat_date = curdate() and stat_type = '1';
    
    open class_cursor;
    read_loop: loop
        fetch class_cursor into v_class_id, v_class_name;
        if done then
            leave read_loop;
        end if;
        
        -- 插入统计数据
        insert into health_check_statistics (
            stat_date, batch_no, class_id, class_name,
            total_students, checked_students, unchecked_students, abnormal_students,
            check_rate, abnormal_rate, stat_type, create_by, create_time
        )
        select 
            curdate(),
            p_batch_no,
            v_class_id,
            v_class_name,
            count(s.student_id) as total_students,
            count(r.record_id) as checked_students,
            count(s.student_id) - count(r.record_id) as unchecked_students,
            count(case when r.check_status = '3' then 1 end) as abnormal_students,
            round(count(r.record_id) * 100.0 / count(s.student_id), 2) as check_rate,
            round(count(case when r.check_status = '3' then 1 end) * 100.0 / count(s.student_id), 2) as abnormal_rate,
            '1',
            'system',
            now()
        from health_student s
        left join health_check_record r on s.student_id = r.student_id and r.batch_no = p_batch_no
        where s.class_id = v_class_id and s.del_flag = '0';
        
    end loop;
    close class_cursor;
end$$
delimiter ;

-- ----------------------------
-- 创建触发器
-- ----------------------------
-- 体检记录状态变更触发器
delimiter $$
create trigger tr_health_record_status_change
    after update on health_check_record
    for each row
begin
    -- 当体检状态变为异常时，自动更新异常项目数
    if new.check_status = '3' and old.check_status != '3' then
        update health_check_record 
        set abnormal_count = (
            select count(*) 
            from health_check_detail 
            where record_id = new.record_id and is_abnormal = '1' and del_flag = '0'
        )
        where record_id = new.record_id;
    end if;
end$$
delimiter ;

-- 体检明细异常状态变更触发器
delimiter $$
create trigger tr_health_detail_abnormal_change
    after update on health_check_detail
    for each row
begin
    -- 当明细异常状态变更时，更新主记录的异常项目数和状态
    if new.is_abnormal != old.is_abnormal then
        update health_check_record 
        set abnormal_count = (
            select count(*) 
            from health_check_detail 
            where record_id = new.record_id and is_abnormal = '1' and del_flag = '0'
        ),
        check_status = case 
            when (select count(*) from health_check_detail where record_id = new.record_id and is_abnormal = '1' and del_flag = '0') > 0 
            then '3' 
            else check_status 
        end
        where record_id = new.record_id;
    end if;
end$$
delimiter ;

-- ----------------------------
-- 创建索引优化
-- ----------------------------
-- 复合索引优化查询性能
create index idx_student_class_status on health_student(class_id, status, del_flag);
create index idx_record_batch_status on health_check_record(batch_no, check_status, del_flag);
create index idx_detail_record_abnormal on health_check_detail(record_id, is_abnormal, del_flag);
create index idx_reminder_student_type on health_check_reminder(student_id, reminder_type, send_status);

-- ----------------------------
-- 脚本执行完成提示
-- ----------------------------
select '健康体检管理系统数据库初始化完成！' as message;
select concat('共创建数据表：', count(*), '张') as table_count 
from information_schema.tables 
where table_schema = database() 
and table_name like 'health_%'; 