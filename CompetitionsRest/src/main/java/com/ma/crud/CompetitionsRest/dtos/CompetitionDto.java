package com.ma.crud.CompetitionsRest.dtos;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CompetitionDto extends BaseDto<Long> {
    @NotNull
    @Size(min = 1)
    private String title;

    @NotNull
    @Size(min = 1)
    private String description;

    @NotNull
    @Size(min = 1)
    private String firstPlacePrize;

    @NotNull
    @Size(min = 1)
    private String category;

    private Long maxPoints;

    @FutureOrPresent
    private LocalDateTime submissionDeadline;

    private boolean isFinished = false;

    private Long judgeId;
}
