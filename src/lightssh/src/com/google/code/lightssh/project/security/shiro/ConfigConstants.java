package com.google.code.lightssh.project.security.shiro;

/**
 * CAS 常量
 * @author YangXiaojin
 *
 */
public interface ConfigConstants {
	
	/** 是否运行CAS */
	public static final String CAS_ENABLED_KEY = "cas.enabled";
	
	/** CAS服务URL地址Key */
	public static final String CAS_SERVER_URL_PREFIX_KEY = "cas.server.url.prefix";
	
	/** CAS服务Key */
	public static final String CAS_SERVICE_KEY = "cas.service";
	
	/** CAS服务器Keysotre*/
	public static final String CAS_SERVER_KEYSTORE_KEY = "cas.server.keystore";
	
	/** 是否显示验证码 */
	public static final String CAPTCHA_ENABLED_KEY = "captcha.enabled";
	
	/** 登录失败几次后显示验证码*/
	public static final String CAPTCHA_LOGIN_IGNORE_TIMES_KEY = "captcha.login.ignore.times";
	
	
}