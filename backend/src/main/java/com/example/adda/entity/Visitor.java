package com.example.adda.entity;
import jakarta.persistence.* ;

@Entity
@Table(name = "visitor")
public class Visitor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "visitor_id", nullable = false)
    private Integer visitorId ;

    @Column(name = "visitor_name" , length = 100 , nullable = false)
    private String visitorName ;

    @Column(name = "phone_number" ,length = 10)
    private String phoneNumber ;

    @Column(name = "visitor_pic" , length = 2048)
    private String visitorPic ;

    @Column(name = "vehicle_number" , length = 50)
    private String vehicleNumber ;
}
