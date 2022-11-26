package com.ma.crud.CompetitionsRest.services;

import com.ma.crud.CompetitionsRest.dtos.CompetitionDto;
import com.ma.crud.CompetitionsRest.models.CompetitionEntity;
import com.ma.crud.CompetitionsRest.repositories.CompetitionsRepository;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompetitionsServiceImpl implements CompetitionsService {
    Logger logger = LoggerFactory.getLogger(CompetitionsServiceImpl.class);

    @Autowired
    private CompetitionsRepository competitionsRepository;

    @Override
    public void save(CompetitionDto competition) {
        CompetitionEntity competitionEntity = new CompetitionEntity(
            competition.getTitle(),
            competition.getCategory(),
            competition.getDescription(),
            competition.getFirstPlacePrize(),
            competition.getMaxPoints(),
            competition.getSubmissionDeadline(),
            competition.isFinished(),
            competition.getJudgeId()
        );
        try {
            competitionsRepository.save(competitionEntity);
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }
    }

    @Override
    @Transactional
    public void update(CompetitionDto competition) {
        try {
            competitionsRepository.findById(competition.getId())
                    .ifPresent(entity -> {
                        entity.setTitle(competition.getTitle());
                        entity.setDescription(competition.getDescription());
                        entity.setCategory(competition.getCategory());
                        entity.setFinished(competition.isFinished());
                        entity.setMaxPoints(competition.getMaxPoints());
                        entity.setFirstPlacePrize(competition.getFirstPlacePrize());
                        entity.setSubmissionDeadline(competition.getSubmissionDeadline());
                    });
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }

    }

    @Override
    public void delete(Long id) {
        try {
            competitionsRepository.deleteById(id);
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }
    }

    @Override
    public List<CompetitionDto> findAll() {
        try {
            return competitionsRepository.findAll().stream()
                            .map(item -> {
                                CompetitionDto comp = new CompetitionDto(
                                        item.getTitle(),
                                        item.getDescription(),
                                        item.getFirstPlacePrize(),
                                        item.getCategory(),
                                        item.getMaxPoints(),
                                        item.getSubmissionDeadline(),
                                        item.isFinished(),
                                        item.getJudgeId()
                                );
                                comp.setId(item.getId());
                                return comp;
                            }).toList();
        } catch (DataAccessException exception) {
            logger.error(exception.getMessage());
            throw exception;
        }
    }
}
