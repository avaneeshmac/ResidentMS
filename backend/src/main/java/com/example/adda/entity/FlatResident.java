package com.example.adda.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(
        name = "flat_resident",
        uniqueConstraints = @UniqueConstraint(
                name = "uq_flat_resident",
                columnNames = {"flat_id", "resident_id", "start_date"}
        )
)
public class FlatResident {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "flat_resident_id", nullable = false)
    private Integer flatResidentId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "flat_id", nullable = false)
    private Flat flat;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "resident_id", nullable = false)
    private Resident resident;

    @OneToMany(mappedBy = "flatResident" , cascade = CascadeType.PERSIST )
    private List<Tenancy> tenants = new ArrayList<>() ;

    @Column(name = "occupancy_type", length = 50, nullable = false)
    private String occupancyType;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;
}