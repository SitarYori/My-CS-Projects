package cn.itcast.petcare.model;   // ← 确认是 model

public class User {
    private int id;
    private String phone;
    private String password;
    private String username;
    private String avatar;

    public User() {}

    public User(String phone, String password, String username) {
        this.phone = phone;
        this.password = password;
        this.username = username;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
}