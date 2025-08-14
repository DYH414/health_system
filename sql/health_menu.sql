-- ----------------------------
-- 健康体检管理系统菜单SQL脚本
-- ----------------------------

-- 一级菜单
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2000, '健康体检', 0, 5, 'health', NULL, 1, 0, 'M', '0', '0', '', 'fa fa-heartbeat', 'admin', sysdate(), '', NULL, '健康体检管理系统');

-- 二级菜单
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2001, '学生管理', 2000, 1, 'student', 'health/student/index', 1, 0, 'C', '0', '0', 'health:student:list', 'fa fa-user', 'admin', sysdate(), '', NULL, '学生信息管理');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2002, '体检项目', 2000, 2, 'item', 'health/item/index', 1, 0, 'C', '0', '0', 'health:item:list', 'fa fa-list-alt', 'admin', sysdate(), '', NULL, '体检项目管理');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2003, '体检批次', 2000, 3, 'batch', 'health/batch/index', 1, 0, 'C', '0', '0', 'health:batch:list', 'fa fa-calendar', 'admin', sysdate(), '', NULL, '体检批次管理');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2004, '体检记录', 2000, 4, 'record', 'health/record/index', 1, 0, 'C', '0', '0', 'health:record:list', 'fa fa-file-text', 'admin', sysdate(), '', NULL, '体检记录管理');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2005, '结果录入', 2000, 5, 'result', 'health/result/input', 1, 0, 'C', '0', '0', 'health:detail:edit', 'fa fa-edit', 'admin', sysdate(), '', NULL, '体检结果录入');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2006, '结果审核', 2000, 6, 'review', 'health/review/index', 1, 0, 'C', '0', '0', 'health:review:list', 'fa fa-check-square', 'admin', sysdate(), '', NULL, '体检结果审核');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2007, '提醒管理', 2000, 7, 'reminder', 'health/reminder/index', 1, 0, 'C', '0', '0', 'health:reminder:list', 'fa fa-bell', 'admin', sysdate(), '', NULL, '体检提醒管理');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2008, '统计分析', 2000, 8, 'statistics', 'health/statistics/index', 1, 0, 'C', '0', '0', 'health:statistics:list', 'fa fa-bar-chart', 'admin', sysdate(), '', NULL, '体检统计分析');

-- 学生管理按钮
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2011, '学生查询', 2001, 1, '', '', 1, 0, 'F', '0', '0', 'health:student:query', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2012, '学生新增', 2001, 2, '', '', 1, 0, 'F', '0', '0', 'health:student:add', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2013, '学生修改', 2001, 3, '', '', 1, 0, 'F', '0', '0', 'health:student:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2014, '学生删除', 2001, 4, '', '', 1, 0, 'F', '0', '0', 'health:student:remove', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2015, '学生导入', 2001, 5, '', '', 1, 0, 'F', '0', '0', 'health:student:import', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2016, '学生导出', 2001, 6, '', '', 1, 0, 'F', '0', '0', 'health:student:export', '#', 'admin', sysdate(), '', NULL, '');

-- 体检项目按钮
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2021, '项目查询', 2002, 1, '', '', 1, 0, 'F', '0', '0', 'health:item:query', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2022, '项目新增', 2002, 2, '', '', 1, 0, 'F', '0', '0', 'health:item:add', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2023, '项目修改', 2002, 3, '', '', 1, 0, 'F', '0', '0', 'health:item:edit', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2024, '项目删除', 2002, 4, '', '', 1, 0, 'F', '0', '0', 'health:item:remove', '#', 'admin', sysdate(), '', NULL, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2025, '项目导出', 2002, 5, '', '', 1, 0, 'F', '0', '0', 'health:item:export', '#', 'admin', sysdate(), '', NULL, ''); 