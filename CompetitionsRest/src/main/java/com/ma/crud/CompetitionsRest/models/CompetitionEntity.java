package com.ma.crud.CompetitionsRest.models;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CompetitionEntity extends BaseEntity<Long> {
    @Column
    @NotNull
    @Size(min = 1)
    private String title;

    @Column
    @NotNull
    @Size(min = 1)
    private String category;

    @Column
    @NotNull
    @Size(min = 1)
    private String description;

    @Column
    @NotNull
    @Size(min = 1)
    private String firstPlacePrize;

    @Column
    private Long maxPoints;

    @Column
    @FutureOrPresent
    private LocalDateTime submissionDeadline;

    @Column
    private boolean isFinished = false;

    @Column
    private Long judgeId;
}
