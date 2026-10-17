package com.fy.entity;

public class User {
    private int id;
    private String username;
    private String password;
    private String role;
    private int status;
    private String avatar;

    // id的getter/setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    // username的getter/setter
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    // password的getter/setter
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // role的getter/setter
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    // status的getter/setter
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    // avatar的getter/setter
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
}