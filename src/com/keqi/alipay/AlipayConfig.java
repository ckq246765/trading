package com.keqi.alipay;

public class AlipayConfig {
	// 商户appid
		public static String APPID = "2016093000627886";
		// 私钥 pkcs8格式的
		public static String RSA_PRIVATE_KEY = "MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQD3YkVfuIrhmlMGWtsTaTlkyuY/7NK/IoZOcytSIFSiUc1zM9sEIhDolGgDiOA+BBGJhjN1T+pCKh7qIkmYsACa+J887/lBxAjaLjG4W1PDcV9kRdAbhqcpMZ9mmtEJ5/uURRynUuqYjdME95gSGJT4WDruXwr2ZqtogDm1cs3Yyll8igba4+vz88/8ijPyXiFbOuH0z7+CkWddJXbVPOW6Y5QomPB8CawcsZTKrZi7EtpmlUCAX7R+ZR5+EB1Gr7eYmV8Bkyom1wxr5UCV8JA3ALGy5uSklP9Rw2ZA1u9Yhc8gPM/iMM9GQyuk/yiADYtZCBtV4vszn81J2Ih8UwkRAgMBAAECggEBAMbZOBhcF06GpOv7xhMRRrANJA0ISNKYZsrSamUGVeFvzawnZ4on891vxTfqIw3WaV5ZAC3xAcUTZGwhCXVxK9tls2HhJ0NE1zTBYvfkeS0liV7pewFVODK1j4KDOTo0PZYOA50/2hCsF43rk1IgbkY9bYlD3mT3XBqQz1JZqLrzP2zRTTb2SSGAtdYz6yLkFjVHUxpzR9wMQY+isk9XqdZpEgwJuMD85ylLoOVYFtyo4A7SjGfzjc3aaGwCP9eKE8VipIYrG4PPySXd2i/IGwbiE8rLUK/qD3RBwIuoewM4G8Iv2wD1lw933XB6IgfsjgY11TENLoh32xHO8FIu8MECgYEA/WAkihYzAoyzosgIRUIbhCnwpH7ELSCnNQZtluGfjHth9uRUJv3U6ZlTAdRaIDXscYhJfNlgiHrg+NuKttS3865I2SNjIG8DCteOTJxoV3c6GAWBnPaCSzGFHHimKXSEWtKA3jXjKCNYw3ghgOam74H9HJG81EpbvJ82Dzf8PzkCgYEA+fI9lHtkFeTpW5hxJoRLTDXEmn6rTlnd4l6M++smOU2wCxk0MAhMe9f0/3QRnzVy25OJlla7CBCszl5clIA3dXbUF761dJ7UK+2Jux+xfFO7Nz3QNrCLAHMajTAUUk+VIOu7Z1hHECmI6eV17HC6UOQmaUUuDQfSQAot/OnbQJkCgYEAubPac/6bOlYnXrofHau7AR3ACsACRlT1V+6zKW+KAWt4vHxSlRVbFC7U4LVjrNH4zqklu0SS9NSiyKIXw7KadBYbvFGsWFwkrbCY0ducueZfhLWcbo9ZpYTQ27ItjpqgWvSHkNWL/KITb4g/ffsPBOGPwn2qGSm6nL9P3s2YqjkCgYEAq7iUOkk0EB6/fOCVDKNjoC5orsRMKX5whS/0qLd8AW6wfk+InV92PLe4aTFzUfDEwrrwkktwIDBkqTwHWzdj4t4LBW1O+ZqNpsiCEf/KTuKwA1oCjTBpr5tlKI9ZxttKV93dWTk7SY1ftWKizBj+yMiW40hWRTmUZ88WnWaF7jECgYEAx4dxmZheIyrN+brWd8U+gbs4l1zIoEuWSbrfIrQxCya0mcO9me5chGscvLTb4lrD+gM3pP/bTzSr3hIluDtco+osXn3wjxqFe8AoSptliGc2+cje2t/9mAERDjbSFDv8JUpEUK/cEwtdcCGbpJXFbog+kFnzBHhRM+C1UcI3e6s=";
		// 服务器异步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
		//public static String notify_url = "http://商户网关/alipay.trade.wap.pay-JAVA-UTF-8/notify_url.jsp";
		public static String notify_url = "http://localhost:8080/trading/notify_url.jsp";
		// 页面跳转同步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问 商户可以自定义同步跳转地址
		//public static String return_url = "http://商户网关地址/alipay.trade.wap.pay-JAVA-UTF-8/return_url.jsp";
		public static String return_url = "http://localhost:8080/trading/return_url.jsp";
		// 请求网关地址
		public static String URL = "https://openapi.alipaydev.com/gateway.do";
		// 编码
		public static String CHARSET = "UTF-8";
		// 返回格式
		public static String FORMAT = "json";
		// 支付宝公钥
		public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjCn68KoGG/153/uEKohYa0BJBHB42OAn9lLaCLDg2erit4fm8hNnO3uoOLRK0uimYHFrwGtBYqFIZUUKaLpMQeVdAuuWPSVMx5Pg5yPn2Zzjtef8aydP73cU5s/vRR8IXH/wh0IzMP6VQqAGhHqx5qMou0s3PLehHAL7E+NjixjodeOiSsBeXSoDoy4qB1OOkOWhYPpSf3BQNaO/2hcR1FGNX3NIkWv0OFKrSBldyQuQX4krMmaxeVAnCGYLNR6BwRQ4huhPoG/Wt1q1zFT9oMW7RA0kTOh7D3uOIXrsykNTDngzLK1DsluWqFGS/7klYkFKIVpe0aY7pBhKy6GmBwIDAQAB";
		// 日志记录目录
		public static String log_path = "/log";
		// RSA2
		public static String SIGNTYPE = "RSA2";
}
