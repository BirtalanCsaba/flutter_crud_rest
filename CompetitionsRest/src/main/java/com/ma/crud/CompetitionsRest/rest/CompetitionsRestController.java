package com.ma.crud.CompetitionsRest.rest;

import com.ma.crud.CompetitionsRest.dtos.CompetitionDto;
import com.ma.crud.CompetitionsRest.services.CompetitionsService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/competitions")
public class CompetitionsRestController {
    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private CompetitionsService competitionsService;

    @GetMapping
    public ResponseEntity<List<CompetitionDto>> findAll() {
        logger.info("Entered: GET /competitions");
        return ResponseEntity.ok(competitionsService.findAll());
    }

    @PostMapping
    public ResponseEntity<CompetitionDto> save(@Valid @RequestBody CompetitionDto competition) {
        logger.info("Entered: POST /competitions with params: " + competition.toString());
        return ResponseEntity.ok(competitionsService.save(competition));
    }

    @PutMapping
    public ResponseEntity<?> update(@Valid @RequestBody CompetitionDto competition) {
        logger.info("Entered: PUT /competitions with params: " + competition.toString());
        competitionsService.update(competition);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable("id") Long id) {
        logger.info("Entered: DELETE /competitions with params: " + id.toString());
        competitionsService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
