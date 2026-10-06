package com.example.adda.entity;

import jakarta.persistence.*;
import java.util.*;

@Entity
@Table(name = "block", uniqueConstraints = @UniqueConstraint(name = "uq_block" , columnNames = {"society_id","block_name"}))
public class Block {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "block_id", nullable = false)
    private Integer blockId ;

    @Column(name = "block_name", length = 100 , nullable = false)
    private String blockName ;

    @Column(name = "total_floors")
    private Integer totalFloors ;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "society_id", nullable = false)
    private Society society ;

    @OneToMany(mappedBy = "block" , cascade = CascadeType.PERSIST)
    private List<Flat> flats = new ArrayList<>() ;


}
