-- Copyright 2004-2024 H2 Group. Multiple-Licensed under the MPL 2.0,
-- and the EPL 1.0 (https://h2database.com/html/license.html).
-- Initial Developer: H2 Group
--

CREATE TABLE TEST(A VARCHAR, B VARCHAR, C VARCHAR AS LOWER(A));
> ok

ALTER TABLE TEST DROP COLUMN B;
> ok

DROP TABLE TEST;
> ok

ALTER TABLE IF EXISTS TEST DROP COLUMN A;
> ok

ALTER TABLE TEST DROP COLUMN A;
> exception TABLE_OR_VIEW_NOT_FOUND_DATABASE_EMPTY_1

CREATE TABLE TEST(A INT, B INT, C INT, D INT, E INT, F INT, G INT, H INT, I INT, J INT);
> ok

ALTER TABLE TEST DROP COLUMN IF EXISTS J;
> ok

ALTER TABLE TEST DROP COLUMN J;
> exception COLUMN_NOT_FOUND_1

ALTER TABLE TEST DROP COLUMN B;
> ok

ALTER TABLE TEST DROP COLUMN IF EXISTS C;
> ok

SELECT * FROM TEST;
> A D E F G H I
> - - - - - - -
> rows: 0

ALTER TABLE TEST DROP COLUMN B, D;
> exception COLUMN_NOT_FOUND_1

ALTER TABLE TEST DROP COLUMN IF EXISTS B, D;
> ok

SELECT * FROM TEST;
> A E F G H I
> - - - - - -
> rows: 0

ALTER TABLE TEST DROP COLUMN E, F;
> ok

SELECT * FROM TEST;
> A G H I
> - - - -
> rows: 0

ALTER TABLE TEST DROP COLUMN (B, H);
> exception COLUMN_NOT_FOUND_1

ALTER TABLE TEST DROP COLUMN IF EXISTS (B, H);
> ok

SELECT * FROM TEST;
> A G I
> - - -
> rows: 0

ALTER TABLE TEST DROP COLUMN (G, I);
> ok

SELECT * FROM TEST;
> A
> -
> rows: 0

DROP TABLE TEST;
> ok

CREATE TABLE T1(ID INT PRIMARY KEY, C INT);
> ok

CREATE VIEW V1 AS SELECT C FROM T1;
> ok

ALTER TABLE T1 DROP COLUMN C;
> exception COLUMN_IS_REFERENCED_1

DROP VIEW V1;
> ok

ALTER TABLE T1 DROP COLUMN C;
> ok

DROP TABLE T1;
> ok
