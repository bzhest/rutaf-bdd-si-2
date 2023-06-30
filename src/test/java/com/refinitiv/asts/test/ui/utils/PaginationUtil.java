package com.refinitiv.asts.test.ui.utils;

public class PaginationUtil {

    public static int getSkipCount(int currentPage, int itemsPerPage) {
        return currentPage * itemsPerPage;
    }

    public static int getTotalPages(int totalItems, int pageSize) {
        return (int) Math.ceil((double) totalItems / pageSize);
    }

    public static int getCurrentPageSize(int totalItems, int pageSize, int pageNo) {
        if (totalItems > pageSize) {
            int size = totalItems;
            for (int i = 0; i < pageNo; i++) {
                size -= pageSize;
            }
            return size < 0 ? 0 : Math.min(size, pageSize);
        }
        return pageNo == 0 ? totalItems : 0;
    }

}
