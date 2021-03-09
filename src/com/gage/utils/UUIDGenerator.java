package com.gage.utils;

import java.util.UUID;

/**
 * UUID生成器
 * @author 陈克齐
 *
 */
public class UUIDGenerator {

	private UUIDGenerator() {}
	
	public static String generator() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
