package cn.itcast.petcare.model;

import java.io.Serializable;

public class ServiceOrder implements Serializable {
    private int id;
    private int userId;
    private String serviceType;  // "boarding" 或 "grooming"
    private String petName;
    private String petType;
    private String serviceName;
    private String serviceDate;
    private String serviceTime;
    private String address;
    private String remark;
    private int status;  // 1=待确认 2=已确认 3=已完成 4=已取消
    private String createTime;

    public ServiceOrder() {}

    // Getter 和 Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getServiceType() { return serviceType; }
    public void setServiceType(String serviceType) { this.serviceType = serviceType; }

    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }

    public String getPetType() { return petType; }
    public void setPetType(String petType) { this.petType = petType; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getServiceDate() { return serviceDate; }
    public void setServiceDate(String serviceDate) { this.serviceDate = serviceDate; }

    public String getServiceTime() { return serviceTime; }
    public void setServiceTime(String serviceTime) { this.serviceTime = serviceTime; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }

    public String getStatusText() {
        switch (status) {
            case 1: return "待确认";
            case 2: return "已确认";
            case 3: return "已完成";
            case 4: return "已取消";
            default: return "未知";
        }
    }
}