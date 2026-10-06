package com.example.adda.entity;

import jakarta.persistence.* ;

@Entity
@Table(name = "role")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "role_id")
    private Integer roleId ;

    @Column(name = "role_name" , length = 100 , nullable = false , unique = true)
    private String roleName ;

    @Column(name = "can_approve_visitors" , nullable = false)
    private Boolean canApproveVisitors ;

    @Column(name = "can_post_notices" , nullable = false)
    private Boolean canPostNotices ;
}
