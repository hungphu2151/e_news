package com.example.e_news.beans;

import java.time.LocalDateTime;

public class DateTime {
    private LocalDateTime now;

    public DateTime(LocalDateTime now) {
        this.now = now;
    }

    public DateTime() {
    }

    public LocalDateTime getNow() {
        return now;
    }
}
