package com.ruoyi.health.mapper;

import java.util.List;
import com.ruoyi.health.domain.Student;

/**
 * 学生信息管理 数据层
 * 
 * @author ruoyi
 */
public interface StudentMapper {
    /**
     * 查询学生信息
     * 
     * @param studentId 学生ID
     * @return 学生信息
     */
    public Student selectStudentById(Long studentId);

    /**
     * 通过学号查询学生信息
     * 
     * @param studentNo 学号
     * @return 学生信息
     */
    public Student selectStudentByStudentNo(String studentNo);

    /**
     * 查询学生列表
     * 
     * @param student 学生信息
     * @return 学生集合
     */
    public List<Student> selectStudentList(Student student);

    /**
     * 查询班级学生列表
     * 
     * @param classId 班级ID
     * @return 学生集合
     */
    public List<Student> selectStudentsByClassId(Long classId);

    /**
     * 新增学生
     * 
     * @param student 学生信息
     * @return 结果
     */
    public int insertStudent(Student student);

    /**
     * 修改学生
     * 
     * @param student 学生信息
     * @return 结果
     */
    public int updateStudent(Student student);

    /**
     * 删除学生
     * 
     * @param studentId 学生ID
     * @return 结果
     */
    public int deleteStudentById(Long studentId);

    /**
     * 批量删除学生
     * 
     * @param studentIds 需要删除的学生ID
     * @return 结果
     */
    public int deleteStudentByIds(Long[] studentIds);

    /**
     * 校验学号是否唯一
     * 
     * @param studentNo 学号
     * @return 结果
     */
    public int checkStudentNoUnique(String studentNo);

    /**
     * 校验身份证号是否唯一
     * 
     * @param idCard 身份证号
     * @return 结果
     */
    public int checkIdCardUnique(String idCard);

    /**
     * 更新学生状态
     * 
     * @param student 学生信息
     * @return 结果
     */
    public int updateStudentStatus(Student student);
}