package com.gage.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CurrentDate {

	private CurrentDate() {}
	public static String getCurrentDate() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(new Date());
	}
}
