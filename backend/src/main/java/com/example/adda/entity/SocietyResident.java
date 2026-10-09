package com.example.adda.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(
        name = "society_resident",
        uniqueConstraints = @UniqueConstraint(
                name = "uq_society_resident",
                columnNames = {"society_id", "resident_id"}
        )
)
public class SocietyResident {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "society_resident_id", nullable = false)
    private Integer societyResidentId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "society_id", nullable = false)
    private Society society;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "resident_id", nullable = false)
    private Resident resident;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @Column(name = "society_resident_status", length = 50, nullable = false)
    private String societyResidentStatus;

    @Column(name = "joined_date", nullable = false)
    private LocalDate joinedDate;

    @Column(name = "left_date")
    private LocalDate leftDate;
}