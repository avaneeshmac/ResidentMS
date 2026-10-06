package com.example.adda.entity;

import jakarta.persistence.*;


@Entity
@Table(name = "resident")
public class Resident {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "resident_id" , nullable = false)
    private Integer residentId ;

    @Column(name = "first_name",length = 100 , nullable = false)
    private String firstName ;

    @Column(name = "last_name", length = 100)
    private String lastName ;

    @Column(name = "phone_number", length = 10 , nullable = false , unique = true)
    private String phoneNumber ;

    @Column(name = "email", length = 255, nullable = false , unique = true)
    private String email ;

    @Column(name = "password_hash" , length = 255 , nullable = false)
    private String passwordHash ;

    @Column(name = "profile_pic" , length = 2048)
    private String profilePic ;

}
