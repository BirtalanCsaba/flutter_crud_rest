package com.ma.crud.CompetitionsRest.services;

import com.ma.crud.CompetitionsRest.dtos.CompetitionDto;

import java.util.List;

public interface CompetitionsService {
    void save(CompetitionDto competition);
    void update(CompetitionDto competition);
    void delete(Long id);
    List<CompetitionDto> findAll();
}
