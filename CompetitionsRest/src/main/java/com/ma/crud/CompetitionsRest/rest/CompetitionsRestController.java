package com.ma.crud.CompetitionsRest.rest;

import com.ma.crud.CompetitionsRest.dtos.CompetitionDto;
import com.ma.crud.CompetitionsRest.services.CompetitionsService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/competitions")
public class CompetitionsRestController {
    @Autowired
    private CompetitionsService competitionsService;

    @GetMapping
    public ResponseEntity<List<CompetitionDto>> findAll() {
        return ResponseEntity.ok(competitionsService.findAll());
    }

    @PostMapping
    public ResponseEntity<?> save(@Valid @RequestBody CompetitionDto competition) {
        competitionsService.save(competition);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping
    public ResponseEntity<?> update(@Valid @RequestBody CompetitionDto competition) {
        competitionsService.update(competition);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable("id") Long id) {
        competitionsService.delete(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
