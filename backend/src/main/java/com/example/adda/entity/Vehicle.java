package com.example.adda.entity;

import jakarta.persistence.*;

@Entity
@Table(
        name = "vehicle",
        uniqueConstraints = @UniqueConstraint(
                name = "uq_vehicle_reg",
                columnNames = {"registration_number"}
        )
)
public class Vehicle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "vehicle_id", nullable = false)
    private Integer vehicleId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "flat_id", nullable = false)
    private Flat flat;

    @Column(name = "registration_number", length = 100, nullable = false, unique = true)
    private String registrationNumber;

    @Column(name = "vehicle_type", length = 50, nullable = false)
    private String vehicleType;
}