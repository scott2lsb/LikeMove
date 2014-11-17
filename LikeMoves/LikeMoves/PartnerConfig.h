//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088611093108997"
//收款支付宝账号
#define SellerID  @"yanglicheng8@kaidechuanmei.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"i41o3ntuhx4o0dmkpyu8iwksl6t3mnpl"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMCL3HdpsMAJwQwQVmQyRCimyA1etdDmoc0OY/Te8x7/L7avNM6zCFCMpYWbFDvR2q2BnXzMMRmTxFgZQi72JOg3VYBRGQOzWmR4yOQvCjyBjgaMdTwkZKGYUu8Kqrp264yGV/HZm9O2ZCgBrWs5e8a0TujZju0Vl7Seu3DtL3qzAgMBAAECgYEAhv0G0Yj9a4TrHIQPrSs4ca+LrSPrH8uxP8uI9FGh7OdHEjJ/OTJ279HK8YIpi06ymtW2DZoyChZ4nrMGnVnfwNvBhTPtIT3lJvV31kP0CSxuIy6LcyN9MgSTBECSBrS8Az9jYLVITRP0nbUvOD4yV/W0rzop3WOvYf/ApZa2rbECQQD8Q0jL0H+uvm4krs5mpIvrpuY5whfIHH/Q64pAZL2QJQBPrxyYo1JVdxzO7mqFbbQ+LiN41/IIGFSGBE8l23v1AkEAw2YZlMJ/THAp129Yeliq+k9MSqO1xFllYHRN7+RxC80tnppNJKkbF0ID0oREugNzk7Ar9dTKxTdmssVX9kNbBwJAU7I/ROA4fNHR2XnmIUgW5GjLmf47xbku7zI2/IZwHpMoN0fyRPJrLtAGTuHrlbmAQ+ErA70iIG1yHcTwPa9EwQJAchonCgVhzMMay+ELa7ZncW/o/xUGSbhiSKbh9BoUIW4ZG6rDLYtKdJRqIv52G6F0VmPj59Pw7KVjZTV0HixK9QJAUiG+QSojWGaR5FmqxnJJgxeY+mpBLxqBZ6okD2kS7muuaSnwCA7pFziK55vguGQqBYVNNMS78Al4wjfvfSVLHA=="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
