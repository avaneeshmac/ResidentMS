package com.example.adda.entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "asset")
public class Asset {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "asset_id" , nullable = false)
    private Integer assetId ;

    @Column(name = "asset_name",length = 500 , nullable = false)
    private String assetName ;

    @Column(name = "purchase_date")
    private LocalDate purchaseDate ;

    @Column(name = "next_service_due")
    private LocalDate nextServiceDue ;

    @Column(name = "asset_status" , length = 50 , nullable = false)
    private Boolean isBookable ;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "society_id" , nullable = false)
    private Society society ;


}
