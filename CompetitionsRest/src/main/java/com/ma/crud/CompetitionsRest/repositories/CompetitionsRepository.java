package com.ma.crud.CompetitionsRest.repositories;

import com.ma.crud.CompetitionsRest.models.CompetitionEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompetitionsRepository extends JpaRepository<CompetitionEntity, Long> {

}
