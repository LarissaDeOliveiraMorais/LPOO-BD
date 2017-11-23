create database pratica6;

create table exemplo1 (
C1 integer not null,
C2 integer,
C3 integer,
C4 integer);

select * from exemplo1;

-- -----------------------------------------------------
-- tempo de execução 0.071 seg
-- -----------------------------------------------------
SELECT * FROM exemplo1 
WHERE c3 = 4801 AND c2 = 4899 AND c4 = 4750;

create index idx_c2 on exemplo1 (c2);
create index idx_c3 on exemplo1 (c3);
create index idx_c4 on exemplo1 (c4);

ANALYZE TABLE exemplo1;

-- -----------------------------------------------------
-- tempo de execução 0.071 seg
-- -----------------------------------------------------
SELECT * FROM exemplo1 
WHERE c3 = 4801 AND c2 = 4899 AND c4 = 4750;


-- -----------------------------------------------------
-- tempo de execução 0.286 seg
-- -----------------------------------------------------
SELECT * FROM exemplo1 WHERE c1 = 5020;


-- -----------------------------------------------------
-- tempo de execução 0.022 seg
-- -----------------------------------------------------
SELECT * FROM exemplo1 WHERE c2 = 5020;
