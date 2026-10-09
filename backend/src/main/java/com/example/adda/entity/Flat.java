package com.example.adda.entity;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "flat" , uniqueConstraints = @UniqueConstraint(name = "uq_flat" , columnNames = {"flat_number","block_id"}))
public class Flat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "flat_id" , nullable = false)
    private Integer flatId ;

    @Column(name = "flat_number" , length = 50 , nullable = false)
    private String flatNumber ;

    @Column(name = "square_foot")
    private BigDecimal squareFoot ;

    @Column(name = "flat_type" , length = 50)
    private String flatType ;

    @Column(name = "current_status" , length = 50 , nullable = false)
    private String currentStatus ;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "block_id" , nullable = false)
    private Block block ;

    @OneToMany(mappedBy = "flat" , cascade = CascadeType.PERSIST )
    private List<FlatResident> flatResidents = new ArrayList<>() ;

    @OneToMany(mappedBy = "flat" , cascade = CascadeType.PERSIST )
    private List<Maintenance> maintenances = new ArrayList<>() ;

    @OneToMany(mappedBy = "flat" , cascade = CascadeType.PERSIST )
    private List<ParkingSlot> parkingSlots = new ArrayList<>() ;

    @OneToMany(mappedBy = "flat" , cascade = CascadeType.PERSIST )
    private List<Vehicle> vehicles = new ArrayList<>() ;

    @OneToMany(mappedBy = "flat" , cascade = CascadeType.PERSIST )
    private List<VisitorLog> visitorLogs = new ArrayList<>() ;



}

