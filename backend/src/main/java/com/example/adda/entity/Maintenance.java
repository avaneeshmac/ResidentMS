package com.example.adda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "maintenance")
public class Maintenance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "maintenance_id", nullable = false)
    private Integer maintenanceId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "flat_id", nullable = false)
    private Flat flat;

    @Column(name = "generation_date", nullable = false)
    private LocalDate generationDate;

    @Column(name = "due_date", nullable = false)
    private LocalDate dueDate;

    @Column(name = "penalty_amt", precision = 10, scale = 2, nullable = false)
    private BigDecimal penaltyAmt;

    @Column(name = "total_due_amt", precision = 10, scale = 2, nullable = false)
    private BigDecimal totalDueAmt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "billed_to", nullable = false)
    private Resident billedTo;

    @OneToMany(mappedBy = "maintenance" , cascade = CascadeType.PERSIST )
    private List<Payment> payments = new ArrayList<>() ;

}