package com.example.adda.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "amenity")
public class Amenity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "amenity_id" , nullable = false)
    private Integer amenityId ;

    @Column(name = "amenity_name",length = 100 , nullable = false)
    private String amenityName ;

    @Column(name = "operational_hours", length = 50)
    private String operationalHours;

    @Column(name = "is_bookable", nullable = false)
    private Boolean isBookable ;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "society_id" , nullable = false)
    private Society society ;

}
