package com.example.e_news.beans;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class User {
    private int id, role, expriration;
    private String username, password, name, email, pen_name;
    private LocalDate dob;
    private LocalDateTime issue_at;


    public User() {
    }

    public User(int id, int role, int expriration, String username, String password, String name, String email, String pen_name, LocalDate dob, LocalDateTime issue_at) {
        this.id = id;
        this.role = role;
        this.expriration = expriration;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.pen_name = pen_name;
        this.dob = dob;
        this.issue_at = issue_at;
    }

    public int getId() {
        return id;
    }

    public int getRole() {
        return role;
    }

    public int getExpriration() {
        return expriration;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPen_name() {
        return pen_name;
    }

    public LocalDate getDob() {
        return dob;
    }

    public LocalDateTime getIssue_at() {
        return issue_at;
    }
}
