create or replace PROCEDURE checkusername(
  un IN Account.username%TYPE,
  pa IN Account.pass%TYPE,
  checker OUT NUMBER
  ) AS
  BEGIN
    checker := 0;
    SELECT p_id INTO checker FROM ACCOUNT WHERE USERNAME = UN AND PASS = PA;
  END;  