package com.example.adda.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;



@Entity
@Table(name = "society")
public class Society {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "society_id", nullable = false)
    private Integer societyId ;

    @Column(name = "society_name",length = 100, nullable = false)
    private String societyName ;

    @Column(name = "registration_number" , length = 100, nullable = false, unique = true)
    private String registrationNumber ;

    @Column(name = "address", length = 255, nullable = false)
    private String address ;

    @Column(name = "city", length = 100, nullable = false)
    private String city ;

    @Column(name = "zip_code")
    private Integer zipCode ;

    @OneToMany(mappedBy = "society", cascade = CascadeType.PERSIST)
    private List<Block> blocks = new ArrayList<>(); //collection of blocks

    @OneToMany(mappedBy = "society" , cascade = CascadeType.PERSIST)
    private List<Amenity> amenities = new ArrayList<>() ; // collection of amenities

    @OneToMany(mappedBy = "society" , cascade = CascadeType.PERSIST)
    private List<Asset> assets = new ArrayList<>()  ;

    @OneToMany(mappedBy = "society" , cascade = CascadeType.PERSIST )
    private List<ParkingSlot> parkingSlots = new ArrayList<>() ;

    @OneToMany(mappedBy = "society" , cascade = CascadeType.PERSIST )
    private List<SocietyResident> societyResidents = new ArrayList<>() ;

    @OneToMany(mappedBy = "society" , cascade = CascadeType.PERSIST )
    private List<Staff> staff = new ArrayList<>() ;


}
