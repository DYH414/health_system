package com.ruoyi.health.controller;

import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.health.domain.Student;
import com.ruoyi.health.service.IStudentService;

/**
 * 学生信息管理 控制层
 * 
 * @author ruoyi
 */
@RestController
@RequestMapping("/health/student")
public class StudentController extends BaseController {
    @Autowired
    private IStudentService studentService;

    /**
     * 获取学生列表
     */
    @PreAuthorize("@ss.hasPermi('health:student:list')")
    @GetMapping("/list")
    public TableDataInfo list(Student student) {
        startPage();
        List<Student> list = studentService.selectStudentList(student);
        return getDataTable(list);
    }

    /**
     * 导出学生列表
     */
    @PreAuthorize("@ss.hasPermi('health:student:export')")
    @Log(title = "学生管理", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(Student student) {
        List<Student> list = studentService.selectStudentList(student);
        ExcelUtil<Student> util = new ExcelUtil<Student>(Student.class);
        return util.exportExcel(list, "学生数据");
    }

    /**
     * 获取学生详细信息
     */
    @PreAuthorize("@ss.hasPermi('health:student:query')")
    @GetMapping(value = "/{studentId}")
    public AjaxResult getInfo(@PathVariable("studentId") Long studentId) {
        return AjaxResult.success(studentService.selectStudentById(studentId));
    }

    /**
     * 新增学生
     */
    @PreAuthorize("@ss.hasPermi('health:student:add')")
    @Log(title = "学生管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Student student) {
        if (!studentService.checkStudentNoUnique(student)) {
            return AjaxResult.error("新增学生'" + student.getStudentName() + "'失败，学号已存在");
        }
        if (StringUtils.isNotEmpty(student.getIdCard()) && !studentService.checkIdCardUnique(student)) {
            return AjaxResult.error("新增学生'" + student.getStudentName() + "'失败，身份证号已存在");
        }
        student.setCreateBy(getUsername());
        return toAjax(studentService.insertStudent(student));
    }

    /**
     * 修改学生
     */
    @PreAuthorize("@ss.hasPermi('health:student:edit')")
    @Log(title = "学生管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Student student) {
        if (!studentService.checkStudentNoUnique(student)) {
            return AjaxResult.error("修改学生'" + student.getStudentName() + "'失败，学号已存在");
        }
        if (StringUtils.isNotEmpty(student.getIdCard()) && !studentService.checkIdCardUnique(student)) {
            return AjaxResult.error("修改学生'" + student.getStudentName() + "'失败，身份证号已存在");
        }
        student.setUpdateBy(getUsername());
        return toAjax(studentService.updateStudent(student));
    }

    /**
     * 删除学生
     */
    @PreAuthorize("@ss.hasPermi('health:student:remove')")
    @Log(title = "学生管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{studentIds}")
    public AjaxResult remove(@PathVariable Long[] studentIds) {
        return toAjax(studentService.deleteStudentByIds(studentIds));
    }

    /**
     * 状态修改
     */
    @PreAuthorize("@ss.hasPermi('health:student:edit')")
    @Log(title = "学生管理", businessType = BusinessType.UPDATE)
    @PutMapping("/changeStatus")
    public AjaxResult changeStatus(@RequestBody Student student) {
        student.setUpdateBy(getUsername());
        return toAjax(studentService.updateStudentStatus(student));
    }

    /**
     * 导入学生数据
     */
    @PreAuthorize("@ss.hasPermi('health:student:import')")
    @Log(title = "学生管理", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<Student> util = new ExcelUtil<Student>(Student.class);
        List<Student> studentList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = studentService.importStudent(studentList, updateSupport, operName);
        return AjaxResult.success(message);
    }

    /**
     * 下载导入模板
     */
    @PreAuthorize("@ss.hasPermi('health:student:import')")
    @GetMapping("/importTemplate")
    public AjaxResult importTemplate() {
        ExcelUtil<Student> util = new ExcelUtil<Student>(Student.class);
        return util.importTemplateExcel("学生数据");
    }
}