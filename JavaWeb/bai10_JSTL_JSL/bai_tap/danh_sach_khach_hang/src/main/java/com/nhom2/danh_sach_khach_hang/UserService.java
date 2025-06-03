package com.nhom2.danh_sach_khach_hang;

import java.util.ArrayList;
import java.util.List;

public class UserService {
    private static List<User> user = new ArrayList<>();

    static{
        user.add(new User("Nguyễn Văn Bình","1-1-2009","Đà Nẵng","https://cdn.prod.website-files.com/66149f879619e045e04cf32a/6740aefeff66c452c2c0e6a4_BaldwinWeekend_Web_1920x1080.jpg"));
        user.add(new User("Nguyễn Văn Bình","1-1-2009","Đà Nẵng","https://cdn.prod.website-files.com/66149f879619e045e04cf32a/6740aefeff66c452c2c0e6a4_BaldwinWeekend_Web_1920x1080.jpg"));
        user.add(new User("Nguyễn Văn Bình","1-1-2009","Đà Nẵng","https://cdn.prod.website-files.com/66149f879619e045e04cf32a/6740aefeff66c452c2c0e6a4_BaldwinWeekend_Web_1920x1080.jpg"));
        user.add(new User("Nguyễn Văn Bình","1-1-2009","Đà Nẵng","https://cdn.prod.website-files.com/66149f879619e045e04cf32a/6740aefeff66c452c2c0e6a4_BaldwinWeekend_Web_1920x1080.jpg"));
    }

    public List<User> findAll(){
        return user;
    }
}
