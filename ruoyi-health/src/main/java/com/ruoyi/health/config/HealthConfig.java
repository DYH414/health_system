package com.ruoyi.health.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ComponentScan;

/**
 * 健康体检模块配置
 *
 * @author ruoyi
 */
@Configuration
@MapperScan("com.ruoyi.health.mapper")
@ComponentScan("com.ruoyi.health")
public class HealthConfig
{

} 