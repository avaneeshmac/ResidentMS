package com.example.adda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(
        name = "tenancy",
        uniqueConstraints = @UniqueConstraint(
                name = "uq_tenancy_flat_resident",
                columnNames = {"flat_resident_id"}
        )
)
public class Tenancy {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tenancy_id", nullable = false)
    private Integer tenancyId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "flat_resident_id", nullable = false, unique = true)
    private FlatResident flatResident;

    @Column(name = "rent_amount", precision = 10, scale = 2, nullable = false)
    private BigDecimal rentAmount;

    @Column(name = "deposit_amount", precision = 10, scale = 2)
    private BigDecimal depositAmount;

    @Column(name = "lease_start", nullable = false)
    private LocalDate leaseStart;

    @Column(name = "lease_end")
    private LocalDate leaseEnd;

    @Column(name = "verification_status", length = 50)
    private String verificationStatus;
}