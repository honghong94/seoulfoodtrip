package com.finalprj.seoulfoodtrip.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTimeFormatUtil {
    public static String changeToYMD(LocalDateTime dateTime){
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    public static String changeToYMDHM(LocalDateTime dateTime){
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm"));
    }
}
