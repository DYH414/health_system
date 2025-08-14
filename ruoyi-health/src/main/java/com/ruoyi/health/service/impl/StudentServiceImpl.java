package com.ruoyi.health.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.health.domain.Student;
import com.ruoyi.health.mapper.StudentMapper;
import com.ruoyi.health.service.IStudentService;

/**
 * 学生信息管理 服务层实现
 * 
 * @author ruoyi
 */
@Service
public class StudentServiceImpl implements IStudentService {
    @Autowired
    private StudentMapper studentMapper;

    /**
     * 查询学生信息
     * 
     * @param studentId 学生ID
     * @return 学生信息
     */
    @Override
    public Student selectStudentById(Long studentId) {
        return studentMapper.selectStudentById(studentId);
    }

    /**
     * 通过学号查询学生信息
     * 
     * @param studentNo 学号
     * @return 学生信息
     */
    @Override
    public Student selectStudentByStudentNo(String studentNo) {
        return studentMapper.selectStudentByStudentNo(studentNo);
    }

    /**
     * 查询学生列表
     * 
     * @param student 学生信息
     * @return 学生集合
     */
    @Override
    public List<Student> selectStudentList(Student student) {
        return studentMapper.selectStudentList(student);
    }

    /**
     * 查询班级学生列表
     * 
     * @param classId 班级ID
     * @return 学生集合
     */
    @Override
    public List<Student> selectStudentsByClassId(Long classId) {
        return studentMapper.selectStudentsByClassId(classId);
    }

    /**
     * 新增学生
     * 
     * @param student 学生信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertStudent(Student student) {
        student.setCreateTime(DateUtils.getNowDate());
        return studentMapper.insertStudent(student);
    }

    /**
     * 修改学生
     * 
     * @param student 学生信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateStudent(Student student) {
        student.setUpdateTime(DateUtils.getNowDate());
        return studentMapper.updateStudent(student);
    }

    /**
     * 删除学生信息
     * 
     * @param studentId 学生ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteStudentById(Long studentId) {
        return studentMapper.deleteStudentById(studentId);
    }

    /**
     * 批量删除学生信息
     * 
     * @param studentIds 需要删除的学生ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteStudentByIds(Long[] studentIds) {
        return studentMapper.deleteStudentByIds(studentIds);
    }

    /**
     * 校验学号是否唯一
     * 
     * @param student 学生信息
     * @return 结果
     */
    @Override
    public boolean checkStudentNoUnique(Student student) {
        Long studentId = StringUtils.isNull(student.getStudentId()) ? -1L : student.getStudentId();
        Student info = studentMapper.selectStudentByStudentNo(student.getStudentNo());
        if (StringUtils.isNotNull(info) && info.getStudentId().longValue() != studentId.longValue()) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验身份证号是否唯一
     * 
     * @param student 学生信息
     * @return 结果
     */
    @Override
    public boolean checkIdCardUnique(Student student) {
        Long studentId = StringUtils.isNull(student.getStudentId()) ? -1L : student.getStudentId();
        if (StringUtils.isNotEmpty(student.getIdCard())) {
            int count = studentMapper.checkIdCardUnique(student.getIdCard());
            if (count > 0) {
                return UserConstants.NOT_UNIQUE;
            }
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 修改学生状态
     * 
     * @param student 学生信息
     * @return 结果
     */
    @Override
    public int updateStudentStatus(Student student) {
        return studentMapper.updateStudentStatus(student);
    }

    /**
     * 导入学生数据
     * 
     * @param studentList     学生数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    @Override
    @Transactional
    public String importStudent(List<Student> studentList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(studentList) || studentList.size() == 0) {
            throw new ServiceException("导入学生数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (Student student : studentList) {
            try {
                // 验证是否存在这个学生
                Student s = studentMapper.selectStudentByStudentNo(student.getStudentNo());
                if (StringUtils.isNull(s)) {
                    student.setCreateBy(operName);
                    student.setCreateTime(DateUtils.getNowDate());
                    student.setDelFlag("0");
                    this.insertStudent(student);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、学号 " + student.getStudentNo() + " 学生 "
                            + student.getStudentName() + " 导入成功");
                } else if (isUpdateSupport) {
                    student.setStudentId(s.getStudentId());
                    student.setUpdateBy(operName);
                    student.setUpdateTime(DateUtils.getNowDate());
                    this.updateStudent(student);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、学号 " + student.getStudentNo() + " 学生 "
                            + student.getStudentName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、学号 " + student.getStudentNo() + " 学生 "
                            + student.getStudentName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、学号 " + student.getStudentNo() + " 学生 " + student.getStudentName()
                        + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }
}