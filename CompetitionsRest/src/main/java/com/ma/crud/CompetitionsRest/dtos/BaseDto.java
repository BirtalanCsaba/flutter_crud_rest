package com.ma.crud.CompetitionsRest.dtos;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BaseDto<ID> {
    ID id;
}
