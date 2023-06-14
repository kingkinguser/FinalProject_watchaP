package com.spring.watcha.common;

public class ValidationUtils {
	
	
	public static boolean isValidPageNumber(String pageNumberStr) {
        try {
            int pageNumber = Integer.parseInt(pageNumberStr);
            return pageNumber > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

}
