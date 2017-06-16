package com.huawei.mm.app;

import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Random;
import java.util.TimeZone;

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
public class ExampleUnitTest {
    @Test
    public void addition_isCorrect() throws Exception {
//        assertEquals(4, 2 + 2);
        Random random = new Random();
//        System.out.print((Math.random() * 9 + 1) * 10000);
        System.out.println(random.nextInt(1000000));

        System.out.println("timeZone==>" + getCurrentTimeZone());
    }

    public static String getCurrentTimeZone(){
        TimeZone tz = TimeZone.getTimeZone("GMT");
        String time = tz.getDisplayName();
        System.out.println("time==>" + time);
        System.out.println("time==>" + tz.getID());
        return createGmtOffsetString(false,true,tz.getRawOffset());
    }

    public static String createGmtOffsetString(boolean includeGmt,boolean includeMinuteSeparator, int offsetMillis) {
        int offsetMinutes = offsetMillis / 60000;
        char sign = '+';
        if (offsetMinutes < 0) {
            sign = '-';
            offsetMinutes = -offsetMinutes;
        }
        StringBuilder builder = new StringBuilder(30);
        builder.append(getDateFormate());
        if (includeGmt) {
            builder.append("GMT");
        }
        builder.append(sign);
        appendNumber(builder, 2, offsetMinutes / 60);
        if (includeMinuteSeparator) {
            builder.append(':');
        }
        appendNumber(builder, 2, offsetMinutes % 60);
        return builder.toString();
    }

    private static void appendNumber(StringBuilder builder, int count, int value) {
        String string = Integer.toString(value);
        for (int i = 0; i < count - string.length(); i++) {
            builder.append('0');
        }
        builder.append(string);
    }

    private static String getDateFormate(){
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd\'T\'HH:mm:ss");
        return sf.format(System.currentTimeMillis());
    }
}