package com.example.test.demotestremotedb.repository;

import com.example.test.demotestremotedb.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
