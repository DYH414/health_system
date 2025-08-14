import request from '@/utils/request'

// 查询学生列表
export function listStudent(query) {
    return request({
        url: '/health/student/list',
        method: 'get',
        params: query
    })
}

// 查询学生详细
export function getStudent(studentId) {
    return request({
        url: '/health/student/' + studentId,
        method: 'get'
    })
}

// 新增学生
export function addStudent(data) {
    return request({
        url: '/health/student',
        method: 'post',
        data: data
    })
}

// 修改学生
export function updateStudent(data) {
    return request({
        url: '/health/student',
        method: 'put',
        data: data
    })
}

// 删除学生
export function delStudent(studentId) {
    return request({
        url: '/health/student/' + studentId,
        method: 'delete'
    })
}

// 导出学生
export function exportStudent(query) {
    return request({
        url: '/health/student/export',
        method: 'get',
        params: query
    })
}

// 学生状态修改
export function changeStudentStatus(studentId, status) {
    const data = {
        studentId,
        status
    }
    return request({
        url: '/health/student/changeStatus',
        method: 'put',
        data: data
    })
}

// 学生导入模板
export function importTemplate() {
    return request({
        url: '/health/student/importTemplate',
        method: 'get'
    })
} 